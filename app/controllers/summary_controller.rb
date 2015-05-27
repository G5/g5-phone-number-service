class SummaryController < ApplicationController
  http_basic_authenticate_with(name: ENV["HTTP_BASIC_AUTH_NAME"], password: ENV["HTTP_BASIC_AUTH_PASSWORD"], except: [:index, :show]) if ENV["HTTP_BASIC_AUTH_NAME"] && ENV["HTTP_BASIC_AUTH_PASSWORD"]

  def index
    @data = Location.all
    render json: @data
  end
end
