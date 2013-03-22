Tradesite::Application.routes.draw do


  #Resources
  resources :chatroom
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
  match '/about',           to: 'pages#about'
  match '/disclaimer',      to: 'pages#disclaimer'
  match '/pricing',         to: 'pages#plans'
  match '/admin',           to: 'pages#admin'

  #Users Pages
  match '/signup',          to: 'users#new'
  match '/updateplan',      to: 'users#paypal'
  match '/paypal/checkout', to: 'users#paypal_checkout'
  match '/confirmpayment',  to: 'users#confirm'
  match '/account',         to: 'users#edit'

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

  #Chatroom
  match '/chatroom',        to: 'chatroom#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
