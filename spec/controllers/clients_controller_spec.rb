require 'spec_helper'

describe ClientsController do

  context "with an autenticated user", auth_controller: true do
    describe "GET index" do
      it "returns http success" do
        get 'index'
        response.should be_success
      end

      it "assigns all clients as @clients" do
        client = G5Updatable::Client.create!("urn" => "g5-cl-6cx7rin-gigity", "name" => "Gigity", uid: "blah-blah-blah")
        get :index
        expect(assigns(:clients)).to eq([client])
      end
    end
  end

  context "without an autenticated user"  do
    describe "GET index" do
      it "returns unauthorized" do
        get 'index'
        response.should_not be_success
      end
    end
  end
  
  describe "GET 'show'" do
    render_views
    before do
      @test_client = G5Updatable::Client.create! "urn" => "g5-cl-6cx7rin-gigity", "name" => "Gigity", uid: "blah-blah-blah"
      @loc1 = Location.create! urn: "g5-cl-6cx7aaa-gigity-1", uid: "uid-1", name: "Gigity 1", client_uid: @test_client.uid
      @loc2 = Location.create! urn: "g5-cl-6cx7bbb-gigity-2", uid: "uid-2", name: "Gigity 2", client_uid: @test_client.uid
    end
    
    it "sets the client" do
      get :show, id: @test_client.urn
      expect(assigns(:client)).to eq(@test_client)
    end

    it "sets locations" do
      get :show, id: @test_client.urn
      expect(assigns(:locations)).to eq([@loc1, @loc2])
    end

    it "returns single layer of json full of relavent locations" do
      get :show, id: @test_client.urn, format: :json
      expect(response.body).to eq([@loc1, @loc2].to_json)
    end
  end

end
