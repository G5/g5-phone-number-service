json.name @location.name
json.urn @location.urn

@number_kinds.each do |number_kind|
  next if number_kind == "ppc"
  json.set! number_kind + "_number", fetch_phone_number(number_kind, @location.phone_numbers)
end

@location.ppc_numbers.each do |ppc_number|
  json.set! ppc_number.cpm_code, ppc_number.number
end

json.set! "phone_number", @phone_number.number if @phone_number.present?
