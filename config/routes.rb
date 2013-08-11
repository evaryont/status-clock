ClockLocations::Application.routes.draw do
  resources :clocks

  resources :statuses

  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  get '/user/:id/status/:lcd' => 'users#status_update', as: :status_update
end
