G5PhoneNumberService::Application.routes.draw do

  mount G5Updatable::Engine => '/g5_updatable'
  resources :locations
  root 'locations#index'
end
