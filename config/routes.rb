Rails.application.routes.draw do
  root 'teams#new'

  resources :teams
end
