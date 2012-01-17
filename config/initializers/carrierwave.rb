require 'journalist'

CarrierWave.configure do |config|
  config.cache_dir = File.join(Rails.root, 'tmp', 'uploads')
  
  config.storage = :file
  config.root = File.join(Rails.root, 'public')
end unless Journalist.engine?