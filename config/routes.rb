Rails.application.routes.draw do

  root "notes#show"

  resources :notes, :only => [:create, :show, :update]
  resources :users, :only => [:create]
  resources :sessions, :only => [:new, :create, :destroy]
end
