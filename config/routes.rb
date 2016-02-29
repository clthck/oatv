Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    unlocks: "users/unlocks"
  }

  devise_scope :user do
    get '/users/add_coach' => 'users/registrations#add_coach'
    post '/users/add_coach' => 'users/registrations#create_coach'
    get '/users/add_player' => 'users/registrations#add_player'
    post '/users/add_player' => 'users/registrations#create_player'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

  get '/pages/:id' => 'pages#show', as: :page, format: false
  root to: 'pages#show', id: 'home'

  # user_root_path for devise sign_in/sign_up redirect
  get '/dashboard' => 'dashboard#index', as: :user_root

  resources :dashboard, only: [:index]

  resources :clubs, only: [] do
    collection do
      get :choose_subscription_plan
      post :activate_subscription_plan
    end
  end

  namespace :matches do
    resources :match_categories, except: [:create] do
      collection do
        post '/' => 'match_categories#datatables_editor_cud'
      end
    end
  end
end
