require 'global_phone'

class PhoneNumbersController < ApplicationController

  before_filter :authenticate_user!

  def update
    @phone_number = PhoneNumber.find(params[:id])
    @location = @phone_number.location
    if GlobalPhone.validate(phone_number_params["number"]) == true
      formatted_number_hash = {"number"=>"#{formatting_options}"}
      @phone_number.update_attributes(formatted_number_hash)
      if @phone_number.update_attributes(formatted_number_hash)
        expire_cached_json
        redirect_to edit_location_path(@location), notice: "The #{@phone_number.number_kind} number for #{@location.name} has been changed to: #{formatting_options}"
      else
        render action: 'edit'
      end
    else
      formatted_number_hash = {"number"=>"#{phone_number_params["number"]}"}
      @phone_number.update_attributes(formatted_number_hash)
      redirect_to edit_location_path(@location), alert: "You entered #{phone_number_params["number"]} for #{@location.name}, which does not match an approved format. This could cause problems with website display and/or SEO."
    end
  end

  private

  def phone_number_params
    params.require(:phone_number).permit(:number, :number_format)
  end

  def expire_cached_json
    expire_action(:controller => '/clients', :action => 'show', :id => @location.client.urn, format: :json)
  end

  def formatting_options
    if phone_number_params["number_format"] == "national_format"
      GlobalPhone.parse(phone_number_params["number"]).national_format
    elsif phone_number_params["number_format"] == "international_format"
      GlobalPhone.parse(phone_number_params["number"]).international_format
    elsif phone_number_params["number_format"] == "contains_letters"
      #TODO format number but allow letters
    elsif phone_number_params["number_format"] == "australian"
      #TODO make company code a variable that pulls from the form params
      GlobalPhone.parse(phone_number_params["number"], :au)
    end
  end

end
