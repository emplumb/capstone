Rails.application.routes.draw do

  get "/" => "pages#index"
  get "/users" => "pages#index"

  get "/users/:id" => "users#show"

  get "/investments/:id" => "investments#show"


end
