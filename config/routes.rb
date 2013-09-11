G5PhoneNumberService::Application.routes.draw do

  post "/locations/update", as: "locations_update"
  resources :locations, only: [:index, :create, :update, :destroy]

  root 'locations#index'

end
