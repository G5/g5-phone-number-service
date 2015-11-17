class Api::BaseApiController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render nothing: true, status: 404
  end
end
