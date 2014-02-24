require "spec_helper"

def create_location
  within("#new_location") do
    fill_in "URN", with: "g5-cl-whatever3-name"
    fill_in "Name", with: "farmhouse"
    fill_in "Default Number", with: "1234567890"
  end
  click_button "Create Location"
end

describe "locations requests" do
  describe "index" do
    before do
      visit locations_path
      http_login
    end

    it "has locations heading" do
      expect(page).to have_content "Locations"
    end

    it "lets me create a new location" do
      create_location
      within("#update_locations") do
        expect(page).to have_selector "#urn--g5-cl-whatever3-name"
        expect(page).to have_selector "#name--farmhouse"
        expect(page).to have_selector "#default_number--1234567890"
      end
    end

    it "lets me update a location" do
      create_location

      within("#update_locations") do
        fill_in "name--farmhouse", with: "myhouse"
      end
      click_button "Save"

      within("#update_locations") do
        expect(page).to have_selector "#name--myhouse"
      end
    end

    it "lets me delete a location" do
      create_location
      within("#update_locations #g5-cl-whatever3-name") do
        click_link "Destroy"
      end
      expect(page).not_to have_selector "#update_locations #g5-cl-whatever3-name"
    end

  end
end