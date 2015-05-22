require "spec_helper"

def create_location
  visit new_client_location_path(@test_client)
  within("#new_location") do
    fill_in "location_urn", with: "g5-cl-whatever-name"
    fill_in "location_name", with: "farmhouse"
    fill_in "location_default_number", with: "1234567890"
  end
  click_button "Create Location"
end

describe "locations requests" do
  describe "index" do
    describe "authenticated user", auth_request: true do
      before do
        @test_client = Client.create! "urn" => "g5-cl-6cx7rin-gigity", "name" => "Gigity"
        visit client_locations_path(@test_client)
      end

      it "has locations heading" do
        expect(page).to have_content "Locations"
      end

      it "lets me create a new location" do
        create_location
        expect(page).to have_selector "#urn--g5-cl-whatever-name"
        expect(page).to have_selector "#name--farmhouse"
        expect(page).to have_selector "#default_number--1234567890"
      end

      it "should not accept invalid URNs" do
        visit new_client_location_path(@test_client)
        within("#new_location") do
          fill_in "location_urn", with: "whatever-name"
        end
        click_button "Create Location"
        expect(page).to have_content "Urn is invalid"
      end

      it "lets me update a location" do
        create_location

        within("#g5-cl-whatever-name") do
          click_link "Edit"
        end

        fill_in "location_name", with: "myhouse"
        click_button "Update Location"

        expect(page).to have_selector "#name--myhouse"
      end

      it "lets me delete a location" do
        create_location
        within("#g5-cl-whatever-name") do
          click_link "Destroy"
        end
        expect(page).not_to have_selector "#g5-cl-whatever-name"
      end
    end

    describe "without http basic auth" do
      before do
        @location = Location.create! "urn" => "g5-cl-6cx7rin-hollywood", "name" => "hollywood", "default_number" => "1234567890"
        visit locations_path
      end

      it "has locations heading" do
        expect(page).to have_content "Locations"
      end
    end

    it "has client apps navigation" do
      Capybara.app_host = 'http://g5-cpns-6cx7rin-hollywood.herokuapp.com'
      visit locations_path
      expect(find_link('CMS')[:href]).to eq("http://g5-cms-6cx7rin-hollywood.herokuapp.com/")
      expect(find_link('Pricing and Availability')[:href]).to eq("http://g5-cpas-6cx7rin-hollywood.herokuapp.com/")
      expect(find_link('Customer Experience Management')[:href]).to eq("http://g5-cxm-6cx7rin-hollywood.herokuapp.com/")
    end
  end
end
