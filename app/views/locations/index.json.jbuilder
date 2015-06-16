json.locations @locations do |location|
  json.name location.name
  json.urn location.urn

  @number_kinds.each do |number_kind|
    json.set! number_kind + "_number", fetch_phone_number(number_kind, location.phone_numbers)
  end
end