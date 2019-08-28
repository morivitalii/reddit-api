require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/s3"

if Rails.env.production?
  s3_options = {
    access_key_id: ENV.fetch("S3_ACCESS_KEY_ID"),
    secret_access_key: ENV.fetch("S3_SECRET_ACCESS_KEY"),
    region: ENV.fetch("S3_REGION"),
    bucket: ENV.fetch("S3_BUCKET"),
    endpoint: ENV.fetch("S3_ENDPOINT")
  }

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::S3.new(public: true, **s3_options),
  }

  Shrine.plugin :default_url_options, store: { host: ENV.fetch("S3_CDN") }
  Shrine.plugin :upload_options, store: { cache_control: "max-age=2592000" }
else
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),
  }
end

Shrine.plugin :activerecord
