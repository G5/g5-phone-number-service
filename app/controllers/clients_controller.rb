class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def show
    @client = Client.find_by_id(params[:id]) || Client.find_by_urn(params[:id])
    @locations = Location.where(client_id: @client.id)

    respond_to do |format|
      format.html 

      # using { render json: @locations } adds an extra level of nesting that we don't want
      format.json { render json: @locations.to_json }
    end
  end
end
