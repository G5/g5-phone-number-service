class WebhooksController < ApplicationController
  HUB_ENDPOINT = "http://g5-hub.herokuapp.com/clients/"

  def update
    ClientFeedLocationCreator.new(client_feed_url).work
    render json: {}, status: :ok
  end

private

  def client_feed_url
    "#{HUB_ENDPOINT}#{params[:urn]}"
  end
end
