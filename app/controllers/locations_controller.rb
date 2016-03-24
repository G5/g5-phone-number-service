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

    @number_kinds = PhoneNumber::NUMBER_KINDS

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @location = Location.includes(:phone_numbers).find_by_urn(params[:id]) || Location.includes(:phone_numbers).find(params[:id])
    @number_kinds = PhoneNumber::NUMBER_KINDS
    respond_to do |format|
      format.json
    end
    @phone_number = NumberFinder.new(params).find_number
    #render json: { phone_number: @phone_number }
  end

  def edit
    @location = Location.find_by_urn(params[:id]) || Location.find(params[:id])

    @numbers = @location.phone_numbers

    @ppc_numbers = @location.ppc_numbers
  end

end
