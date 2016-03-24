require "spec_helper"

describe NumberFinder do
  describe "find_number" do
    let(:finder) { NumberFinder.new(parameters) }
    let(:parameters) { { "cpm_code" => cpm_code, "width" => width, "location_urn" => urn } }
    let(:cpm_code) { nil }
    let(:width) { 1001 }
    let(:urn) { "loc-urn" }

    before do
      loc = Location.create!(urn: "loc-urn", name: "test", uid: "test-uid", client_uid: "client-uid")

      PhoneNumber.create! number: "1234567890", number_kind: "default", location_id: loc.id
      PhoneNumber.create! number: "9876543210", number_kind: "mobile",  location_id: loc.id
      PhoneNumber.create! number: "1122334455", number_kind: "ppc", cpm_code: "hey-look-a-cpm-code", location_id: loc.id
    end

    context "with a cpm code" do
      let(:cpm_code) { "hey-look-a-cpm-code" }

      it "returns the matching ppc number" do
        expect(finder.find_number.number).to eq('1122334455')
      end
    end

    context "with a mobile width" do
      let(:width) { 550}

      it "returns the mobile number" do
        expect(finder.find_number.number).to eq('9876543210')
      end
    end

    context "with neither" do
      it "returns the default number" do
        expect(finder.find_number.number).to eq('1234567890')
      end
    end

    context "when the location is not found" do
      let(:urn) { "not-a-thing" }
      it "returns the default number" do
        expect(finder.find_number).to be_nil
      end
    end
  end
end
