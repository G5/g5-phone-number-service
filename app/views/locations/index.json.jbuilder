json.array!(@locations) do |location|
  json.extract! location, :urn, :name, :non_mobile_number, :mobile_number, :ppc_number
  json.url location_url(location, format: :json)
end
