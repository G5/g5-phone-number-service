class LocationsController < ApplicationController
  before_action :set_location, only: [:edit, :update, :destroy]

  def index
    # Still need to deal with the clientless index view for a while
    # This can be removed once we've fixed all the consumer URLs
    if params[:client_id] && Client.find(params[:client_id])
      @client = Client.find(params[:client_id])
      @locations = @client.locations
    else
      @locations = Location.all
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
  end

  def new
    @client = Client.find(params[:client_id])
    @location = Location.new
  end

  def create
    @client = Client.find(params[:client_id])
    @location = @client.locations.new(location_params)
    if @location.save
      redirect_to client_locations_path(@client), notice: 'Location was successfully created.'
    else
      render action: 'new', alert: 'Location was NOT created'
    end
  end

  def update
    if @location.update(location_params)
      redirect_to root_path, notice: 'Location was successfully updated.'
    else
      render action: 'edit', alert: 'Location was NOT updated'
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_url, notice: 'Location was successfully deleted.'
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:urn, :name, :default_number, :mobile_number, :ppc_number)
    end
end
