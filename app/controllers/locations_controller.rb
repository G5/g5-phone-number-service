class LocationsController < ApplicationController
  before_action :set_location, only: [:destroy]

  def index
    @locations = Location.all
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to root_path, notice: 'Location was successfully created.'
    else
      redirect_to root_path, notice: 'Location was NOT successfully created.'
    end
  end

  def update
    success = nil

    puts "*" * 80
    puts params
    puts "*" * 80

    if success
      redirect_to root_path, notice: 'Locations were updated.'
    else
      redirect_to root_path, notice: 'Locations were NOT updated.'
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_url
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:urn, :name, :default_number, :mobile_number, :ppc_number)
    end
end
