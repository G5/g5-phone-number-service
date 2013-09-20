require 'spec_helper'

describe LocationsController do

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      response.should be_success
      response.status.should eq(200)
    end

    it "renders the index template" do
      get :index
      response.should render_template(:index)
    end

    it "loads all locations into @locations" do
      location1, location2 = Location.create!, Location.create!
      get :index
      expect(assigns(:locations)).to match_array([location1, location2])
    end
  end
  
  describe "POST #create" do
    
  end

end