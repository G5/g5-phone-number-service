class LocationsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]

  def index
    # Still need to deal with the clientless index view for a while
    # This can be removed once we've fixed all the consumer URLs
    if params[:client_id] && Client.find(params[:client_id])
      @client = Client.find(params[:client_id])
      @locations = @client.locations
    else
      @locations = Location.includes(:phone_numbers).all
    end

    respond_to do |format|
      format.html
      format.json { render json: @locations }
    end
  end

  def show
    @location = Location.find_by_urn(params[:id]) || Location.find(params[:id])
    render json: @location
  end

  def edit
    @location = Location.find_by_urn(params[:id]) || Location.find(params[:id])

    @numbers = @location.phone_numbers
  end

end
