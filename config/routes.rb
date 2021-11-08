Rails.application.routes.draw do

  root to: 'accounts#index'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :accounts do 
    resources :transactions
  end

  namespace :api, defaults: { format: :json } do
    get     'users/:user_id/transactions',              to: 'transactions#index'
    post    'users/:user_id/transactions',              to: 'transactions#create'
    get     'users/:user_id/transactions/:id',          to: 'transactions#show',        as: :transaction
  end
end
