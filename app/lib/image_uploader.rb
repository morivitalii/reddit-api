# frozen_string_literal: true

require "image_processing/vips"

class ImageUploader < Shrine
  Attacher.promote { |data| Shrine::Attacher.promote(data) }
  Attacher.delete { |data| Shrine::Attacher.delete(data) }

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
    validate_max_size 20.megabytes
    validate_mime_type_inclusion %w(image/png image/jpg image/jpeg)
    validate_extension_inclusion %w(png jpg jpeg)
  end

  add_metadata do |io, context|
    next unless context[:action] == :store

    original_metadata = JSON.parse(context[:record].image_data)["metadata"]
    filename = "#{File.basename(original_metadata["filename"], ".*")} #{context[:version] || "original"}#{File.extname(context[:metadata]["filename"])}"

    image = Shrine.with_file(io) { |file| Vips::Image.new_from_file(file.path) }
    width, height = image.size

    {
      filename: filename,
      width: width,
      height: height
    }
  end

  process(:store) do |io, context|
    io.download do |original|

    desktop = ImageProcessing::Vips.source(original.path).saver(quality: 100).resize_to_limit(825, nil).call
    desktop.open

    # Extract original file metadata
    io.refresh_metadata!(context)
    { original: io, desktop: desktop }
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
