require "spec_helper"

def create_location
  visit new_location_path
  within("#new_location") do
    fill_in "location_urn", with: "g5-cl-whatever-name"
    fill_in "location_name", with: "farmhouse"
    fill_in "location_default_number", with: "1234567890"
  end
  click_button "Create Location"
end

describe "locations requests" do
  describe "index" do
    describe "with http basic auth" do
      before do
        visit locations_path
        http_login
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
        visit new_location_path
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

      it "doesnt let me create a new location" do
        visit new_location_path
        expect(page).to have_text "HTTP Basic: Access denied."
      end

      it "doesnt let me update a location" do
        within("#g5-cl-6cx7rin-hollywood") do
          click_link "Edit"
        end
        expect(page).to have_text "HTTP Basic: Access denied."
      end

      it "doesnt let me delete a location" do
        within("#g5-cl-6cx7rin-hollywood") do
          click_link "Destroy"
        end
        expect(page).to have_text "HTTP Basic: Access denied."
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
