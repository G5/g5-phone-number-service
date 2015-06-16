require "spec_helper"

describe "locations requests" do
  describe "index" do
    describe "authenticated user", auth_request: true do
      before do
        @test_client = Client.create! "urn" => "g5-cl-6cx7rin-gigity", "name" => "Gigity", "uid" => "whatever"
        visit client_locations_path(@test_client.id)
      end

      it "has locations heading" do
        expect(page).to have_content "Locations"
      end

      # it "lets me update a location" do
      #   create_location

      #   within("#g5-cl-whatever-name") do
      #     click_link "Edit"
      #   end

      #   fill_in "location_name", with: "myhouse"
      #   click_button "Update Location"

      #   expect(page).to have_selector "#name--myhouse"
      # end

    end
  end
end
