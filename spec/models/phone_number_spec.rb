require 'spec_helper'

describe PhoneNumber do
  it "requires a number" do
    expect(PhoneNumber.new(number: "")).to_not be_valid
  end

  it "strips non-digit characters" do
    num = PhoneNumber.new(number: "+01 (321) 456-7890")
    num.save
    expect(num.reload.number).to eq("013214567890")

  end

  context "with a ppc number" do
    it "requires a cpm code" do
      num = PhoneNumber.new(cpm_code: "", number: "123-456-7890", number_kind: "ppc")
      expect(num).to_not be_valid
    end

    it "requires a number" do
      num = PhoneNumber.new(cpm_code: "abc123", number: "", number_kind: "ppc")
      expect(num).to_not be_valid
    end

    it "enforces unique cpm codes per location" do
      PhoneNumber.create(cpm_code: "abc123", number: "123-456-7890", number_kind: "ppc", location_id: 1)
      num = PhoneNumber.new(cpm_code: "abc123", number: "987-654-3210", number_kind: "ppc", location_id: 1)
      expect(num).to_not be_valid
    end
  end

  describe "#display_number" do
    let(:number) { PhoneNumber.create(number: "123-456-7890", number_kind: "mobile", location_id: 1) }

    it "adds dashes to a standard 10 digit phone number" do
      expect(number.display_number).to eq("123-456-7890")
    end
  end
end
