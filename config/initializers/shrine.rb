require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/s3"

if Rails.env.production?
  s3_options = {
      access_key_id: Rails.application.credentials.spaces_access_key_id,
      secret_access_key: Rails.application.credentials.spaces_secret_access_key,
      region: Rails.application.credentials.spaces_region,
      bucket: Rails.application.credentials.spaces_bucket,
      endpoint: Rails.application.credentials.spaces_endpoint
  }

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::S3.new(public: true, **s3_options),
  }

  Shrine.plugin :default_url_options, store: { host: Rails.application.credentials.spaces_cdn }
else
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),
  }
end

Shrine.plugin :activerecord
Shrine.plugin :determine_mime_type
Shrine.plugin :remove_invalid
Shrine.plugin :logging
Shrine.plugin :upload_options, store: { cache_control: "max-age=2592000" }
Shrine.plugin :backgrounding