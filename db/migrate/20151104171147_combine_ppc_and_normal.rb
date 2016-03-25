class CombinePpcAndNormal < ActiveRecord::Migration
  def up
    ppc_numbers = PpcNumber.all
    ppc_numbers.each do |num|
      PhoneNumber.create(
        number: num.number,
        location_uid: num.location_uid,
        number_kind: "ppc",
        location_id: num.location_id,
        cpm_code: num.cpm_code,
        notes: num.notes
      )
    end
  end

  def down
    ppc_numbers = PhoneNumber.where(number_kind: "ppc")
    ppc_numbers.each do |num|
      PpcNumber.create(
        number: num.number,
        location_uid: num.location_uid,
        location_id: num.location_id,
        cpm_code: num.cpm_code,
        notes: num.notes
      )
    end
  end
end
