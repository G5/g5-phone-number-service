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
      redirect_to root_path, alert: 'Location was NOT successfully created.'
    end
  end

  def update
    respond_to do |format|
      if @location.update(location_params)
        redirect_to root_path, notice: 'Floor plan was successfully updated.'
      else
        render action: 'edit', alert: 'Location was NOT successfully updated.'
      end
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_url, notice: 'Floor plan was successfully deleted.'
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:urn, :name, :default_number, :mobile_number, :ppc_number)
    end
end
