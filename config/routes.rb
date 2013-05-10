Tradesite::Application.routes.draw do

  #Resources
  resources :users
  resources :pages
  resources :sessions
  resources :password_resets
  resources :posts
  resources :answers
  resources :videos
  resources :alerts

  #Root
  root                      to: 'posts#index'

  #Pages
  get '/about',             to: 'pages#about'
  get '/disclaimer',        to: 'pages#disclaimer'
  get '/pricing',           to: 'pages#plans'
  match '/admin',           to: 'pages#admin'

  #Users Pages
  get   '/signup',          to: 'users#new'
  match '/confirmpayment',  to: 'users#confirm'
  match '/account',         to: 'users#edit'
  match '/checkout',        to: 'users#checkout', :as => "checkout"

  #Sessions Pages
  match '/login',           to: 'sessions#new'
  match '/logout',          to: 'sessions#destroy'

  #Password Resets
  match '/reset',           to: 'password_resets#new'

  #Posts
  match '/posts/new',       to: 'posts#new'
  match '/deletePost',      to: 'posts#deletePost'

  #Answers
  match '/retrieve_answers',to: 'answers#retrieve'

  #Videos
  match '/videos',          to: 'videos#index'
  match '/videos/new',      to: 'videos#new'

  #Alerts
  match '/message',         to: 'alerts#new'

end
