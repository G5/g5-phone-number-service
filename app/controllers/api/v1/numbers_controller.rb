class Api::V1::NumbersController < Api::BaseApiController

  def show
    number = PhoneNumber.find_by_number(params[:phone_number])
    render json: PhoneNumberSerializer.new(number), root: false
  end
end
