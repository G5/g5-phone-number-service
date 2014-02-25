require "spec_helper"

describe LocationsController do

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

    it "loads all locations into @locations" do
      location1, location2 = Location.create!, Location.create!
      get :index
      expect(assigns(:locations)).to match_array([location1, location2])
    end
  end

  describe "POST #create" do
    describe "with http basic auth" do
      before :each do
        http_login
      end

      describe "when it saves" do
        it "redirects to root path" do
          Location.any_instance.stub(:save).and_return(true)
          LocationsController.any_instance.stub(:location_params).and_return {}
          post :create
          expect(response).to redirect_to(root_path)
          flash[:notice].should eq "Location was successfully created."
        end
      end

      describe "when it does not save" do
        it "redirects to root path" do
          Location.any_instance.stub(:save).and_return(false)
          LocationsController.any_instance.stub(:location_params).and_return {}
          post :create
          expect(response).to redirect_to(root_path)
          flash[:alert].should eq "Location was NOT successfully created."
        end
      end

      describe "when it's given invalid params" do
        it "raises an error" do
          expect {post :create}.to raise_error(ActionController::ParameterMissing)
        end
      end

      describe "when it's given valid params" do
        it "does not raise an error" do
          expect {post :create, :location => {urn: "g5-cl-whatever-3"}}.not_to raise_error()
        end
      end
    end

    describe "without http basic auth" do
      describe "when it saves" do
        it "receives a 401 response code" do
          post :create
          response.response_code.should == 401
        end
      end
    end
  end

  describe "PUT #update" do
    describe "with http basic auth" do
      before :each do
        http_login
      end

      describe "when it saves" do
        it "redirects to root path" do
          LocationsController.any_instance.stub(:update_locations).and_return true
          put :update
          expect(response).to redirect_to(root_path)
          flash[:notice].should eq "Locations were updated."
        end
      end

      describe "when it does not save" do
        it "redirects to root path" do
          LocationsController.any_instance.stub(:update_locations).and_return false
          put :update
          expect(response).to redirect_to(root_path)
          flash[:alert].should eq "Locations were NOT updated."
        end
      end
    end
    describe "without http basic auth" do
      describe "when it saves" do
        it "receives a 401 response code" do
          put :update
          response.response_code.should == 401
        end
      end
    end
  end
end