G5PhoneNumberService::Application.routes.draw do

  get 'clients/index'

  mount G5Updatable::Engine => '/g5_updatable'
  resources :clients
  resources :locations
  root 'locations#index'
end
