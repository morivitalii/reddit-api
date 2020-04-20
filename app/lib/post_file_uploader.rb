require "image_processing/mini_magick"

class PostFileUploader < Shrine
  plugin :activerecord
  plugin :determine_mime_type
  plugin :store_dimensions, analyzer: :mini_magick
  plugin :processing
  plugin :versions

  plugin :validation_helpers, default_messages: {
    max_size: ->(maximum) { I18n.t("activerecord.errors.models.post.attributes.file.size", size: Plugins::ValidationHelpers::PRETTY_FILESIZE.call(maximum)) },
    mime_type_inclusion: ->(mime_types) { I18n.t("activerecord.errors.models.post.attributes.file.mime_type", formats: mime_types.to_sentence) },
    extension_inclusion: ->(extensions) { I18n.t("activerecord.errors.models.post.attributes.file.extension", formats: extensions.to_sentence) }
  }

  Attacher.validate do
    validate_max_size 30.megabytes
    validate_mime_type_inclusion %w[image/png image/jpg image/jpeg]
    validate_extension_inclusion %w[png jpg jpeg]
  end

  process(:store) do |io, _context|
    versions = {original: io}

    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original).quality(100)

      versions[:desktop] = pipeline.resize_to_limit!(825, nil)
      versions[:mobile] = pipeline.resize_to_limit!(425, nil)
    end

    versions
  end
end
