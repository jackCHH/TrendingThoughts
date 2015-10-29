Rails.application.routes.draw do

  resources :tweets
  root 'tweets#new'
  
end
