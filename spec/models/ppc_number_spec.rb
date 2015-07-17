require 'spec_helper'

describe PpcNumber do
  it "requires a cpm code" do
    PpcNumber.new(cpm_code: "", number: "123-456-7890").should_not be_valid
  end

  it "requires a number" do
    PpcNumber.new(cpm_code: "abc123", number: "").should_not be_valid
  end

  it "enforces unique cpm codes per location" do
    PpcNumber.create(cpm_code: "abc123", number: "123-456-7890", location_id: 1)
    PpcNumber.new(cpm_code: "abc123", number: "987-654-3210", location_id: 1).should_not be_valid
  end
end
