G5PhoneNumberService::Application.routes.draw do

  mount G5Authenticatable::Engine => '/g5_auth'
  mount G5Updatable::Engine => '/g5_updatable'

  resources :clients do
    resources :locations
  end

  resources :locations
  resources :phone_numbers

  # Root will eventually point to 'clients#index' once we 
  # are sure we've correctly updated all the CPNS consumers

  root 'clients#index'

  get '/:id/locations', to: 'clients#show'
end
