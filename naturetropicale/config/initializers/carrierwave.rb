require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['SECRET_ACCESS_KEY']
      # region: 'us-east-1'
    }
    config.fog_directory  = ENV['FOG_DIRECTORY']
    # config.fog_public     = false
    config.storage = :fog
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end
