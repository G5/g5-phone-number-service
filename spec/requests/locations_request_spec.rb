require "spec_helper"

def create_location
  visit new_location_path
  within("#new_location") do
    fill_in "location_urn", with: "g5-cl-whatever3-name"
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
        expect(page).to have_selector "#urn--g5-cl-whatever3-name"
        expect(page).to have_selector "#name--farmhouse"
        expect(page).to have_selector "#default_number--1234567890"
      end

      it "lets me update a location" do
        create_location

        within("#g5-cl-whatever3-name") do
          click_link "Edit"
        end

        fill_in "location_name", with: "myhouse"
        click_button "Update Location"

        expect(page).to have_selector "#name--myhouse"
      end

      it "lets me delete a location" do
        create_location
        within("#g5-cl-whatever3-name") do
          click_link "Destroy"
        end
        expect(page).not_to have_selector "#g5-cl-whatever3-name"
      end
    end

    describe "without http basic auth" do
      before do
        @location = Location.create! "urn" => "g5-cl-6cx7rin-hollywood", "name" => "hollywood"
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
  end
end