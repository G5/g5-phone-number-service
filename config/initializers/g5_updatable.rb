G5Updatable.setup do |config|
  config.update_locations = true
  config.update_client = false
  config.location_parameters = [:name, :urn]
end
