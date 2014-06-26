class WebhooksController < ApplicationController
  def update
    LocationCreator.new(params[:urn]).work
    render json: {}, status: :ok
  end
end
