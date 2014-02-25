class LocationsController < ApplicationController
  http_basic_authenticate_with(name: ENV["HTTP_BASIC_AUTH_NAME"], password: ENV["HTTP_BASIC_AUTH_PASSWORD"], except: :index) if ENV["HTTP_BASIC_AUTH_NAME"] && ENV["HTTP_BASIC_AUTH_PASSWORD"]
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.all
  end

  def edit
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to root_path, notice: 'Location was successfully created.'
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
