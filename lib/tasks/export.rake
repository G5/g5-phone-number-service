namespace :export do
  task phone_numbers: :environment do
    phones = Array.new

    PhoneNumber.where('number IS NOT null').find_each do |phone|
      unless phone.number.blank?
        phones << {pns_id:       phone.id,
                   phone_type:   phone.number_kind,
                   phone_number: phone.number,
                   location_urn: phone.location.try(:urn)}
      end
    end

    PpcNumber.find_each do |phone|
      unless phone.number.blank?
        phones << {pns_id:       phone.id,
                   phone_type:   'ppc',
                   phone_number: phone.number,
                   notes:        phone.notes,
                   cpm_code:     phone.cpm_code,
                   location_urn: phone.location.try(:urn)}
      end
    end

    File.write('export.json', phones.to_json)
  end
end