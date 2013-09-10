G5PhoneNumberService::Application.routes.draw do

  resources :locations, only: [:index, :create, :update, :destroy]

  root 'locations#index'

end
