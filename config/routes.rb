G5PhoneNumberService::Application.routes.draw do

  mount G5Updatable::Engine => '/g5_updatable'

  resources :clients
  resources :locations

  root 'locations#index'

  get '/:id', to: 'clients#show'
end
