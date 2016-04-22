class ClientsController < ApplicationController
  before_filter :authenticate_user!, except: :show

  # caches_action :show, if: Proc.new { request.format.json? }

  def index
    @clients = G5Updatable::Client.all.order(:name)
  end

  def show
    @client = G5Updatable::Client.find_by_urn(params[:id]) || (not_found and return)

    @locations = Location.includes(:phone_numbers, :ppc_numbers).where(client_uid: @client.uid).order(:name)

    @number_kinds = PhoneNumber::NUMBER_KINDS

    respond_to do |format|
      format.html 
      format.json 
    end
  end

  private

  def not_found
    render text: "404 not found", status: 404
  end
end
