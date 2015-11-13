require 'spec_helper'

describe ApplicationHelper do
  describe "#fetch_phone_number" do
    let(:numbers) { [ PhoneNumber.new(number_kind: "default", number: "1234567890"),
                      PhoneNumber.new(number_kind: "mobile",  number: "9876543210"),
                      PhoneNumber.new(number_kind: "ppc",     number: nil) ] }

    it "returns the phone number you're looking for" do
      expect(helper.fetch_phone_number('default', numbers)).to eq("123-456-7890")
    end

    it "returns an empty string if a given number is nil" do
      expect(helper.fetch_phone_number('ppc', numbers)).to eq("")
    end
  end
end
