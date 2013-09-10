json.array!(@locations) do |location|
  json.extract! location, :urn, :name, :default_number, :mobile_number, :ppc_number
  json.url location_url(location, format: :json)
end
