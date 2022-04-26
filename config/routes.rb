# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :trips, only: %i[index create show]
    scope 'stats' do
      get '/weekly', to: 'trips#weekly'
      get '/monthly', to: 'trips#monthly'
    end
  end
end
