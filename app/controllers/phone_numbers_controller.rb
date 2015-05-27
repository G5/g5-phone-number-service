class PhoneNumbersController < ApplicationController
  def new
  end

  def create
  end

  def update
    @phone_number = PhoneNumber.find(params[:id])
    @location = @phone_number.location
    @phone_number.update_attributes(phone_number_params)

    if @phone_number.update_attributes(phone_number_params)
      redirect_to client_path(@location.client), notice: "The #{@phone_number.number_kind} number for #{@location.name} has been updated"
    else
      render action: 'edit'
    end
  end

  def edit
  end

  def destroy
  end

  def index
  end

  private

  def phone_number_params
    params.require(:phone_number).permit(:number)
  end
end
