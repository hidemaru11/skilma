require "shrine"
require "shrine/storage/file_system"
require 'shrine/storage/s3'

if Rails.env.production?
  s3_options = {
    access_key_id:     Rails.application.credentials.dig(:aws, :access_key_id),
    secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
    region:            "ap-northeast-1",
    bucket:            "skilmaimage"}

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
    store: Shrine::Storage::S3.new(prefix: 'store', **s3_options)}
  
  asset_host = "https://static.static.skilma.net"
  Shrine.plugin :default_url_options, cache: { public: true, host: cdn_host }, store: { public: true, host: asset_host }
else
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store")}
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :derivatives,
  create_on_promote:      true,
  versions_compatibility: true