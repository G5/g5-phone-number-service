ENV["G5_HUB_ENDPOINT"] ||= case Rails.env
  when "production"  then "http://g5-hub.herokuapp.com/clients/"
  when "development" then "foo"
  when "test"        then "foo"
end
