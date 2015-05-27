G5PhoneNumberService::Application.routes.draw do

  mount G5Updatable::Engine => '/g5_updatable'
  resources :locations
  resources :summary
  root 'locations#index'
end
