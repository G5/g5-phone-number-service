class LocationsController < ApplicationController
  http_basic_authenticate_with name: ENV["HTTP_BASIC_AUTH_NAME"], password: ENV["HTTP_BASIC_AUTH_PASSWORD"] if ENV["HTTP_BASIC_AUTH_NAME"] && ENV["HTTP_BASIC_AUTH_PASSWORD"], except: :index
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
      redirect_to root_path, alert: 'Location was NOT successfully created.'
    end
  end

  def update
    if update_locations(params)
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
    def update_locations(params)
      success = false

      locations = {}

      # build up nested locations hash
      params.each do |k, v|
        location = {}

        if k =~ /location_/
          k.match(/location_(g5-cl-\w+-\w+(-\w+)*)--(\w+)/)

          if locations[$1].nil?
            locations[$1] = {}
          end

          locations[$1][$3] = v
        end

      end

      locations.each do |k,v|
        Location.where(:urn => k).first.update_attributes!(v)
      end

      # naively assumes all locations saved
      success = true
    end
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:urn, :name, :default_number, :mobile_number, :ppc_number)
    end
end
