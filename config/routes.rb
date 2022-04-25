Rails.application.routes.draw do
  namespace :api do
    resources :trips, only: [:index, :create, :show]
    scope 'stats' do 
      get '/weekly', to: 'trips#weekly'
      get '/monthly', to: 'trips#monthly'
    end
  end
end
