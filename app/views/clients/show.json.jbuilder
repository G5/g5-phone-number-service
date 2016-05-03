json.locations @locations do |location|
  json.name location.name
  json.urn location.urn
  json.country_code_prefix location.country_code_prefix

  @number_kinds.each do |number_kind|
    json.set! number_kind + "_number", fetch_phone_number(number_kind, location.phone_numbers)
  end

  location.ppc_numbers.each do |ppc_number|
    json.set! ppc_number.cpm_code, ppc_number.number
  end

  json.ppc_number ""
  
end

