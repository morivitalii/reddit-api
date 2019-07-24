# frozen_string_literal: true

require "streamio-ffmpeg"
require "image_processing/vips"

class Uploader < Shrine
  Attacher.promote do |data|
    metadata = JSON.parse(data["attachment"])["metadata"]

    if metadata["mime_type"].in?(%w(image/gif video/mp4))
      StoreFileJob.perform_later(data)
    else
      StoreFileJob.perform_now(data)
    end
  end

  Attacher.delete { |data| DeleteFileJob.perform_later(data) }

  plugin :validation_helpers, default_messages: {
      max_size: ->(_) { I18n.t("errors.messages.invalid_file_size") },
      mime_type_inclusion: ->(whitelist) { I18n.t("errors.messages.invalid_file_format", whitelist: whitelist.join(", ")) },
      extension_inclusion: ->(whitelist) { I18n.t("errors.messages.invalid_file_format", whitelist: whitelist.join(", ")) }
  }

  plugin :add_metadata
  plugin :refresh_metadata
  plugin :processing
  plugin :versions
  plugin :delete_raw

  metadata_method :type, :width, :height, :duration

  Attacher.validate do
    if get.content_type.in?(%w(image/png image/jpg image/jpeg))
      validate_max_size 20.megabytes
    end

    if get.content_type.in?(%w(image/gif))
      validate_max_size 100.megabytes
    end

    if get.content_type.in?(%w(video/mp4))
      validate_max_size 30.megabytes
    end

    validate_mime_type_inclusion %w(image/png image/jpg image/jpeg image/gif video/mp4)
    validate_extension_inclusion %w(png jpg jpeg gif mp4)
  end

  add_metadata do |io, context|
    next unless context[:action] == :store

    original_metadata = JSON.parse(context[:record].file_data)["metadata"]
    filename = "#{File.basename(original_metadata["filename"], ".*")} #{context[:version] || "original"}#{File.extname(context[:metadata]["filename"])}"

    if context[:metadata]["mime_type"] == "video/mp4"
      movie = Shrine.with_file(io) { |file| FFMPEG::Movie.new(file.path) }

      {
        type: original_metadata["mime_type"] == "image/gif" ? :gif : :video,
        filename: filename,
        width: movie.width,
        height: movie.height,
        duration: movie.duration
      }
    else
      image = Shrine.with_file(io) { |file| Vips::Image.new_from_file(file.path) }
      width, height = image.size

      {
        type: :image,
        filename: filename,
        width: width,
        height: height
      }
    end
  end

  process(:store) do |io, context|
    io.download do |original|
      if io.content_type == "video/mp4"
        screenshot = Tempfile.new(["", ".jpg"], binmode: true)
        FFMPEG::Movie.new(original.path).screenshot(screenshot.path)
        screenshot.open # refresh file descriptor

        desktop = ImageProcessing::Vips.source(screenshot).saver(quality: 100).resize_to_limit(720, 360).call
        [desktop].each(&:open)

        # Extract original file metadata
        io.refresh_metadata!(context)
        { original: io, desktop: desktop }
      elsif io.content_type == "image/gif"
        gif = FFMPEG::Movie.new(original.path)
        mp4 = Tempfile.new(["", ".mp4"], binmode: true)
        gif.transcode(mp4.path)
        mp4.open # refresh file descriptor

        screenshot = Tempfile.new(["", ".jpg"], binmode: true)
        gif.screenshot(screenshot.path)
        screenshot.open # refresh file descriptor

        desktop = ImageProcessing::Vips.source(screenshot).saver(quality: 100).resize_to_limit(720, 360).call
        [desktop].each(&:open)

        { original: mp4, desktop: desktop }
      else
        desktop = ImageProcessing::Vips.source(original.path).saver(quality: 100).resize_to_limit(825, nil).call
        [desktop].each(&:open)

        # Extract original file metadata
        io.refresh_metadata!(context)
        { original: io, desktop: desktop }
      end
    end
  end

  def generate_location(io, context = {})
    if context[:action] == :store
      extension = ".#{io.extension}" if io.is_a?(UploadedFile) && io.extension
      extension ||= File.extname(extract_filename(io).to_s).downcase

      "#{context[:record].to_param}_#{context[:version]}#{extension}"
    else
      super
    end
  end
end
