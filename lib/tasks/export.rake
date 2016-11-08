namespace :export do
  desc 'export the PNS data into a JSON that can be imported into g5-call-tracking'
  task phone_numbers: :environment do
    phones = Array.new

    PhoneNumber.where("number IS NOT null and number != ''").find_each do |phone|
      phones << {pns_id:       phone.id,
                 phone_type:   phone.number_kind,
                 phone_number: phone.number,
                 location_urn: phone.location.try(:urn)}
    end

    PpcNumber.where("number IS NOT null and number != ''").find_each do |phone|
      phones << {pns_id:       phone.id,
                 phone_type:   'ppc',
                 phone_number: phone.number,
                 notes:        phone.notes,
                 cpm_code:     phone.cpm_code,
                 location_urn: phone.location.try(:urn)}
    end

    File.write('export.json', phones.to_json)
  end
end
