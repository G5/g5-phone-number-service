require "spec_helper"

describe ClientFeedLocationCreator do
  let(:location_creator) { described_class.new(feed) }
  let(:feed) { "#{Rails.root}/spec/support/client_feed.html" }

  describe "#work" do
    subject { location_creator.work }

    context "no matching locations in the database" do
      it "creates new locations" do
        expect { subject }.to change { Location.all.size }.from(0).to(2)
      end
    end

    context "matching locations in the database" do
      before do
        Fabricate(:location, urn: "g5-cl-1qrcyt46-hollywood")
        Fabricate(:location, urn: "g5-cl-1qrcyt47-north-shore-oahu")
      end

      it "creates no new locations" do
        expect { subject }.to_not change { Location.all.size }.from(2).to(0)
      end
    end
  end
end
