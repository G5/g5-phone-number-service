require 'spec_helper'

describe PhoneNumbersController do
  let(:client) { FactoryGirl.create(:client) }
  let(:location) { FactoryGirl.create(:location, client: client) }

  describe "POST #create", auth_controller: true do
    let(:response) { post :create, params }

    context "with a successful number" do
      let(:params) do
        {
          phone_number: {
            location_id: location.id,
            number: "987-654-3210",
            number_kind: "ppc",
            cpm_code: "googlething"
          }
        }
      end

      it "creates the number" do
        expect(PhoneNumber.count).to be_zero
        response
        expect(PhoneNumber.count).to eq(1)
      end

      it "redirects to edit location" do
        expect(response).to redirect_to(edit_location_path(id: location.urn))
      end
    end

    context "with an unsuccessful number" do
      let(:params) do
        {
          phone_number: {
            location_id: location.id,
            number: "987-654-3210",
            number_kind: "ppc"
          }
        }
      end

      it "does not create the number" do
        expect(PhoneNumber.count).to be_zero
        response
        expect(PhoneNumber.count).to be_zero
      end

      it "redirects to edit location" do
        expect(response).to redirect_to(edit_location_path(id: location.urn))
      end
    end
  end

  describe "POST #update", auth_controller: true do
    let(:response) { post :update, params }
    let!(:number) { PhoneNumber.create(location_id: location.id, number: "987-654-3210", number_kind: "mobile") }

    context "with a successful update" do
      let(:params) do
        {
          id: number.id,
          phone_number: {
            number: "987-654-1111",
            number_kind: "mobile"
          }
        }
      end

      it "updates the number" do
        response
        expect(number.reload.number).to eq("9876541111")
      end

      it "redirects to edit location" do
        expect(response).to redirect_to(edit_location_path(id: location.urn))
      end
    end

    context "with an unsuccessful number" do
      let(:params) do
        {
          id: number.id,
          phone_number: {
            number: "987-654-1111",
            number_kind: "ppc",
            cpm_code: ""
          }
        }
      end

      it "does not update the number" do
        response
        expect(number.reload.number).to eq("9876543210")
      end

      it "redirects to edit location" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy", auth_controller: true do
    let(:response) { post :destroy, params }
    let!(:number) { PhoneNumber.create(location_id: location.id, number: "987-654-3210", number_kind: "mobile") }
    let(:params) { { id: number.id } }

    it "deletes the number" do
      expect(PhoneNumber.all.count).to eq(1)
      response
      expect(PhoneNumber.all.count).to eq(0)
    end
  end
end
