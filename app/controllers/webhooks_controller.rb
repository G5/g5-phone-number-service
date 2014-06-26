class WebhooksController < ApplicationController
  def update
    ClientFeedLocationCreator.new(client_feed_url).work
    render json: {}, status: :ok
  end

private

  def client_feed_url
    "#{ENV["G5_HUB_ENDPOINT"]}#{params[:urn]}"
  end
end
