require "spec_helper"

describe Location do
  describe "validations" do
    it "requires name" do
      expect(Fabricate.build(:location, name: "")).to_not be_valid
    end

    it "requires default_number" do
      expect(Fabricate.build(:location, default_number: "")).to_not be_valid
    end

    describe "urn" do
      let!(:existing_location) do
        Fabricate(:location, urn: "g5-cl-i1e2zsv1-good-lock-self-storage")
      end

      it "requires urn" do
        expect(Fabricate.build(:location, urn: "")).to_not be_valid
      end

      it "requires a unique urn" do
        expect(Fabricate.build(:location, urn: "g5-cl-i1e2zsv1-good-lock-self-storage")).
          to_not be_valid
      end

      it "requires a specific format" do
        expect(Fabricate.build(:location, urn: "i1xsvf6u-twenty25-foo")).
          to_not be_valid
      end

      it "allows a number in the location name" do
        expect(Fabricate.build(:location, urn: "g5-cl-i1xsvf6u-twenty25-foo")).
          to be_valid
      end
    end
  end
end
