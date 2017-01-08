Rails.application.routes.draw do

  get "/" => "pages#index"

  get "/investments" => "investments#index"
  get "/investments/:id" => "investments#show"

  get "/portfolios/new" => "portfolios#new"
  post "/portfolios" => "portfolios#create"
  get "/portfolios/:id" => "portfolios#show"
  delete "/portfolios/:id" => "portfolios#destroy"

  get "/signup" => "users#new"
  post "/users" => "users#create"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/investment_portfolios/" => "investment_portfolios#index"
  post "/investment_portfolios/" => "investment_portfolios#create"
  delete "/investment_portfolios/:id" => "investment_portfolios#destroy"


end
