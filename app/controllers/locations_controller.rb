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

    success = false

    locations = {}

    # build up nested locations hash
    params.each do |k, v|
      location = {}

      if k =~ /location_/
        k.match(/location_(g5-c-\w+-\w+)--(\w+)/)

        if locations[$1].nil?
          locations[$1] = {}
        end

        locations[$1][$2] = v
      end

    end

    locations.each do |k,v|
      Location.where(:urn => k).first.update_attributes!(v)
    end

    # naively assumes all locations saved
    success = true

    if success
      redirect_to root_path, notice: 'Locations were updated.'
    else
      redirect_to root_path, alert: 'Locations were NOT updated.'
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
