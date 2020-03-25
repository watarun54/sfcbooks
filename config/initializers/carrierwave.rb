unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_S3_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_S3_SECRET_ACCESS_KEY'],
      region: ENV['AWS_S3_REGION']
    }

    config.fog_directory  = ENV['AWS_S3_BUCKET']
    config.cache_storage = :fog
  end
end
