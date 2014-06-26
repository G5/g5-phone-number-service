G5PhoneNumberService::Application.routes.draw do

  resources :locations
  root 'locations#index'

  post "update" => "webhooks#update"
end
