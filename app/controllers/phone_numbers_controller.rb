class PhoneNumbersController < ApplicationController

  before_filter :authenticate_user!

  def update
    @phone_number = PhoneNumber.find(params[:id])
    @location = @phone_number.location
    @phone_number.update_attributes(phone_number_params)

    if @phone_number.update_attributes(phone_number_params)
      expire_cached_json
      redirect_to edit_location_path(@location), notice: "The #{@phone_number.number_kind} number for #{@location.name} has been updated"
    else
      render action: 'edit'
    end
  end

  def create
    @location = Location.find_by_id(params[:phone_number][:location_id]) || Location.find_by_urn(params[:location_id])
    @number = @location.phone_numbers.new(phone_number_params)

    if @number.save
      expire_cached_json
      redirect_to edit_location_path(@location), notice: "The #{@number.cpm_code} number for #{@location.name} has been created"
    else
      # render action: 'edit'
      redirect_to edit_location_path(@location), alert: "The PPC number was not saved. You must enter a unique CPM code and a phone number."
    end
  end

  private

  def phone_number_params
    params.require(:phone_number).permit(:number, :cpm_code, :notes, :number_kind)
  end

  def expire_cached_json
    expire_action(:controller => '/clients', :action => 'show', :id => @location.client.urn, format: :json)
  end
end
