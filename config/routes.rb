G5PhoneNumberService::Application.routes.draw do

  # get 'phone_numbers/new'

  # get 'phone_numbers/create'

  # get 'phone_numbers/update'

  # get 'phone_numbers/edit'

  # get 'phone_numbers/destroy'

  # get 'phone_numbers/index'

  mount G5Authenticatable::Engine => '/g5_auth'
  mount G5Updatable::Engine => '/g5_updatable'

  resources :clients do
    resources :locations
  end

  resources :locations

  resources :phone_numbers

  # Root will eventually point to 'clients#index' once we 
  # are sure we've correctly updated all the CPNS consumers
  root 'locations#index'

  get '/:id', to: 'clients#show'
end
