require 'spec_helper'

describe PhoneNumber do
  it "requires a number" do
    PhoneNumber.new(number: "").should_not be_valid
  end

  context "with a ppc number" do
    it "requires a cpm code" do
      PhoneNumber.new(cpm_code: "", number: "123-456-7890", number_kind: "ppc").should_not be_valid
    end

    it "requires a number" do
      PhoneNumber.new(cpm_code: "abc123", number: "", number_kind: "ppc").should_not be_valid
    end

    it "enforces unique cpm codes per location" do
      PhoneNumber.create(cpm_code: "abc123", number: "123-456-7890", number_kind: "ppc", location_id: 1)
      PhoneNumber.new(cpm_code: "abc123", number: "987-654-3210", number_kind: "ppc", location_id: 1).should_not be_valid
    end
  end
end
