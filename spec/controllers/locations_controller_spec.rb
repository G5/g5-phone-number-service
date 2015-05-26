require "spec_helper"

describe LocationsController do

  # This should return the minimal set of attributes required to create a valid
  # Location. As you add validations to Location, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "urn" => "g5-cl-6cx7rin-hollywood", "name" => "Hollywood", "uid" => "blah-blah-blah", "client_uid" => "whatever" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LocationsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "speaks json too" do
      get :index, format: :json
      expect(response.status).to eq(200)
    end

    it "loads all locations into @locations" do
      location1 = Location.create! valid_attributes
      location2 = Location.create! "urn" => "g5-cl-6cx7rin-farmhouse", "name" => "Farmhouse", "uid" => "yadda-yadda-yadda", "client_uid" => "whatever"
      get :index
      expect(assigns(:locations)).to match_array([location1, location2])
    end
  end

  describe "GET #show" do
    let!(:location) { Fabricate(:location) }
    it "renders a location as json" do
      get :show, id: location.id
      expect(response.body).to eq(location.to_json)
    end
    it "supports lookup by urn" do
      get :show, id: location.urn
      expect(response.body).to eq(location.to_json)
    end
  end
end
