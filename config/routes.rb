Rails.application.routes.draw do
  get 'checkout/index'

  post 'checkout/place_order'=>'checkout#place_order',:as=>:place_order

  get 'checkout/thank_you'

  devise_for :users
  get 'catalog/index'

  get 'catalog/show'

  get 'catalog/search'

  get 'catalog/latest'

  namespace :admin do
    resources :books
  end
  namespace :admin do
    resources :publishers
  end
  
  namespace :admin do
  resources :author
  end

 

  get 'about/index'
  match '/cart/add/:id' => 'cart#add', :via => [:get, :post], :as => :cart_add
  match '/cart/remove/:id' => 'cart#remove', :via => [:get, :post], :as => :cart_remove
  get "/cart/clear"
  # get 'cart/:id/add'=>'cart#add',:as => :cart_add
  # match ':cart/:add/:id', via: [:get, :post]

  # post 'cart/:id/add'=>'cart#add',:as => :cart_add

  mount Thredded::Engine => '/forum'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'catalog#index'

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
