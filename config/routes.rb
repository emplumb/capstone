Rails.application.routes.draw do

  get "/" => "pages#index"
  get "/users" => "pages#index"

  get "/investments" => "investments#index"
  get "/investments/:id" => "investments#show"

  get "/portfolios/:id" => "portfolios#show"

  get "/users/:id" => "users#show"
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
