Rails.application.routes.draw do
  

 

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
get '/auth/google_oauth2'
  get 'project/index'
  get 'project/show'
get 'project/alltask'
get 'project/update'
post 'project/update'
get 'project/new'
get 'project/destroy'
get 'project/edit'
post 'project/edit'
get 'project/create'
get 'project/update'
get 'project/uptasks'
post 'project/uptasks'
post 'project/create'
 get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :users
  resources :project

  
root  'project#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
