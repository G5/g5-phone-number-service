require "spec_helper"

describe LocationsController do

  # This should return the minimal set of attributes required to create a valid
  # Location. As you add validations to Location, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "urn" => "g5-cl-6cx7rin-hollywood", "name" => "Hollywood", "default_number" => "1234567890" } }

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
      location2 = Location.create! "urn" => "g5-cl-6cx7rin-farmhouse", "name" => "Farmhouse", "default_number" => "1234567890"
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

  describe "POST #create" do
    describe "with authenticated user", auth_controller: true do
      before :each do
        @test_client = Client.create! "urn" => "g5-cl-6cx7rin-gigity", "name" => "Gigity"
      end

      describe "when it saves" do
        it "redirects to root path" do
          Location.any_instance.stub(:save).and_return(true)
          LocationsController.any_instance.stub(:location_params).and_return {}
          post :create, client_id: @test_client.id
          expect(response).to redirect_to(client_locations_path(@test_client))
          flash[:notice].should eq "Location was successfully created."
        end
      end

      describe "when it does not save" do
        it "renders new location path" do
          Location.any_instance.stub(:save).and_return(false)
          LocationsController.any_instance.stub(:location_params).and_return {}
          post :create, client_id: @test_client.id
          expect(response).to render_template("new")
        end
      end

      describe "when it's given invalid params" do
        it "raises an error" do
          expect {post :create, client_id: @test_client.id}.to raise_error(ActionController::ParameterMissing)
        end
      end

      describe "when it's given valid params" do
        it "does not raise an error" do
          expect {post :create, client_id: @test_client.id, :location => {urn: "g5-cl-whatever-3"}}.not_to raise_error()
        end
      end
    end
  end

  describe "PUT #update" do
    describe "authenticated user", auth_controller: true do
      describe "when it saves" do
        it "redirects to root path" do
          location = Location.create! valid_attributes
          put :update, {:id => location.to_param, :location => valid_attributes}, valid_session
          expect(response).to redirect_to(root_path)
          flash[:notice].should eq "Location was successfully updated."
        end
      end

      describe "when it does not save" do
        it "renders the edit template" do
          location = Location.create! valid_attributes
          Location.any_instance.stub(:save).and_return(false)
          put :update, {:id => location.to_param, :location => { "urn" => "invalid value" }}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "non-authorized users" do
    before do
      @test_client = Client.create! "urn" => "g5-cl-6cx7rin-gigity", "name" => "Gigity"
      @test_location = Location.create! valid_attributes
      @new_attrs = { urn: "g5-cl-xxxxxxx-hell", name: "hell", default_number: "666-666-6666" }
    end

    it "can see index" do
      get :index
      expect(response).to be_success
    end

    it "can see show" do
      get :show, id: @test_location.id
      expect(response).to be_success
    end

    it "can't new" do
      get :new, client_id: @test_client.id
      expect(response).not_to be_success
    end

    it "can't edit" do
      get :edit, id: @test_location.id
      expect(response).not_to be_success
    end

    it "can't update" do
      post :update, id: @test_location.id, location: @new_attrs
      @test_location.reload
      expect(@test_location.name).to eq(valid_attributes["name"])
    end

    it "can't create" do
      expect{
        post :create, client_id: @test_client.id, location: @new_attrs
      }.to change{Location.all.count}.by(0)
    end

    it "can't destroy" do
      expect{
        delete :destroy, id: @test_location.id
      }.to change{Location.all.count}.by(0)
    end
  end
end
