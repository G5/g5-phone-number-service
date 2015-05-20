require 'spec_helper'

describe ClientsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    render_views
    before do
      @test_client = Client.create! "urn" => "g5-cl-6cx7rin-gigity", "name" => "Gigity"
      @loc1 = Location.create! urn: "g5-cl-6cx7aaa-gigity-1", name: "Gigity 1", client_id: @test_client.id, default_number: "1234567890"
      @loc2 = Location.create! urn: "g5-cl-6cx7bbb-gigity-2", name: "Gigity 2", client_id: @test_client.id, default_number: "1234567890"
    end
    
    it "sets the client" do
      get :show, id: @test_client.id
      expect(assigns(:client)).to eq(@test_client)
    end

    it "sets locations" do
      get :show, id: @test_client.id
      expect(assigns(:locations)).to eq([@loc1, @loc2])
    end

    it "returns single layer of json full of relavent locations" do
      get :show, id: @test_client.urn, format: :json
      expect(response.body).to eq([@loc1, @loc2].to_json)
    end
  end

end
