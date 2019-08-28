# frozen_string_literal: true

require "image_processing/mini_magick"

class ImageUploader < Shrine
  plugin :determine_mime_type
  plugin :store_dimensions, analyzer: :mini_magick
  plugin :processing
  plugin :versions

  plugin :validation_helpers, default_messages: {
    max_size: ->(_) { I18n.t("errors.messages.invalid_file_size") },
    mime_type_inclusion: ->(whitelist) { I18n.t("errors.messages.invalid_file_format", whitelist: whitelist.join(", ")) },
    extension_inclusion: ->(whitelist) { I18n.t("errors.messages.invalid_file_format", whitelist: whitelist.join(", ")) }
  }

  Attacher.validate do
    validate_max_size 20.megabytes
    validate_mime_type_inclusion %w(image/png image/jpg image/jpeg)
    validate_extension_inclusion %w(png jpg jpeg)
  end

  process(:store) do |io, context|
    versions = { original: io }

    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original).quality(100)

      versions[:desktop] = pipeline.resize_to_limit!(825, nil)
    end

    versions
  end
end
