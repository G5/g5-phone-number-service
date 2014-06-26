class WebhooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def update
    ClientFeedLocationCreator.new(client_feed_url).work
    render json: {}, status: :ok
  end

private

  def client_feed_url
    "#{ENV["G5_HUB_ENDPOINT"]}#{params[:urn]}"
  end
end
