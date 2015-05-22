class ClientsController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def index
    @clients = Client.all
  end

  def show
    @client = Client.find_by_id(params[:id]) || Client.find_by_urn(params[:id])
    @locations = Location.where(client_id: @client.id)

    respond_to do |format|
      format.html 
      # using { render json: @locations } adds an extra level of nesting that we don't want
      format.json { render json: @locations.to_json }
    end
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render action: 'new'
    end
    
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render action: 'edit'
    end 
  end

  def edit
    @client = Client.find(params[:id])
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_url
  end

  private

  def client_params
    params.require(:client).permit(:urn, :name)
  end

end
