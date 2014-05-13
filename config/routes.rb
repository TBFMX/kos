Rails.application.routes.draw do
  get 'gateway/index'
  post 'gateway/index'

  get 'gateway/paypal'
  get 'gateway/pago_paypal'
  get 'gateway/dineromail'
  get 'gateway/mercadopago'

  controller :gateway do
    get 'gateway/paypal' => :paypal
    post 'gateway/paypal' => :pago_paypal


  end

  resources :line_items

  resources :carts
  resources :cart

  get 'store/index'
  
  delete 'line_items/' =>'line_items#destroy'

  resources :products


  get 'welcome/index'

  resources :module5s

  resources :module4s

  resources :module3s

  resources :module2s

  resources :module1s

  get 'password_resets/new'

  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
=begin
  controller :welcome do
    get 'welcome/index' => :new
    post 'welcome/index' => :create
    delete 'welcome/index' => :destroy
    delete 'welcome/logout' => :destroy
    #post '/' => :create
    #delete '/' => :destroy
    #delete '/logout' => :destroy
  end
=end
  
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :welcome

  resources :users

  resources :rols

  resources :password_resets

  controller :users do
    get 'recover_password' => :recover_password
    post 'recover_password' => :recover_password 
    get 'new_recover_password' => :new_recover_password
    post 'new_recover_password' => :new_recover_password 
    get 'cambiar_password' => :cambiar_password
    post 'cambiar_password' => :cambiar_password
    get 'new_cambiar_password' => :new_cambiar_password
    post 'new_cambiar_password' => :new_cambiar_password
  end 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'store#index', as: 'store'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
