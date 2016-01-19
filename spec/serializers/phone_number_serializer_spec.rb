require 'spec_helper'

describe PhoneNumberSerializer do
  let(:client) { FactoryGirl.create(:client) }
  let(:location) { FactoryGirl.create(:location, client: client) }
  let(:number) do
    PhoneNumber.new(
      number: "9876543210",
      number_kind: "ppc",
      cpm_code: "googlestuff",
      notes: "omg cool number!",
      location_id: location.id
    )
  end

  subject(:hash) { PhoneNumberSerializer.new(number, root: false).as_json.with_indifferent_access }

  it "has the correct attributes" do
    expect(hash[:id]).to eq(number.id)
    expect(hash[:number]).to eq(number.number)
    expect(hash[:number_kind]).to eq(number.number_kind)
    expect(hash[:cpm_code]).to eq(number.cpm_code)
    expect(hash[:notes]).to eq(number.notes)
    expect(hash[:location_uid]).to eq(location.uid)
  end

end
