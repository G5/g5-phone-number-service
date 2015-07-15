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
      @number1 = PhoneNumber.create! number: "1234567890", number_kind: "default", location_id: @loc1.id
      @number2 = PhoneNumber.create! number: "9876543210", number_kind: "mobile",  location_id: @loc2.id
      @number3 = PpcNumber.create! number: "1111111111", cpm_code: "google",  location_id: @loc1.id
      @number4 = PpcNumber.create! number: "2222222222", cpm_code: "bing",  location_id: @loc2.id
    end
    
    it "sets the client" do
      get :show, id: @test_client.urn
      expect(assigns(:client)).to eq(@test_client)
    end

    it "sets locations" do
      get :show, id: @test_client.urn
      expect(assigns(:locations)).to eq([@loc1, @loc2])
    end

    context "Json feed of location phone numbers" do
      before do
        get :show, id: @test_client.urn, format: :json
        @json_feed = JSON.parse(response.body)
      end

      it "returns json full of relavent locations" do
        expect(@json_feed['locations'].length).to eq(2)
      end

      it "includes the location urn in each object" do
        expect(@json_feed['locations'].first['urn']).to eq(@loc1.urn)
      end

      it "includes relevant phone numbers for each object" do
        expect(@json_feed['locations'].first['default_number']).to eq(@number1.number)
      end

      it "includes relevant phone numbers for each object" do
        expect(@json_feed['locations'].last['mobile_number']).to eq(@number2.number)
      end

      it "returns an empty string instead of nil for non existent numbers" do
        expect(@json_feed['locations'].first['mobile_number']).to eq("")
      end

      it "returns the relevant PPC numbers" do
        expect(@json_feed['locations'].first['google']).to eq(@number3.number)
      end
    end
  end

end
