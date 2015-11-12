require "spec_helper"

describe Location do
  describe "#ppc_numbers" do
    let(:client) { FactoryGirl.create(:client) }
    let!(:location) do
      Location.create!(
        uid: "something",
        urn: "g5-cl-12345678-hollywoo",
        name: "Hollywoo",
        client: client
      )
    end

    let!(:default) { location.phone_numbers.create(number: "111-111-1111", number_kind: "default") }
    let!(:mobile) { location.phone_numbers.create(number: "222-222-2222", number_kind: "mobile") }
    let!(:ppc1) { location.phone_numbers.create(number: "333-333-3333", number_kind: "ppc", cpm_code: "test1") }
    let!(:ppc2) { location.phone_numbers.create(number: "444-444-4444", number_kind: "ppc", cpm_code: "test2") }

    it "returns only the ppc numbers" do
      ppc = location.ppc_numbers
      expect(ppc).to_not include(default)
      expect(ppc).to_not include(mobile)
      expect(ppc).to include(ppc1)
      expect(ppc).to include(ppc2)
    end
  end
end
