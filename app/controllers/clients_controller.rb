class ClientsController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def index
    @clients = G5Updatable::Client.all.order(:name)
  end

  def show
    @client = G5Updatable::Client.find_by_urn(params[:id])

    # @locations = Location.where(client_uid: @client.uid)

    @locations = Location.includes(:phone_numbers).where(client_uid: @client.uid)

    respond_to do |format|
      format.html 
      # using { render json: @locations } adds an extra level of nesting that we don't want
      format.json { render json: @locations.to_json }
    end
  end

end
