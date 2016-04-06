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
  get '/dashboard' => 'dashboard#index_for_coach', constraints: lambda { |request| request.env['warden'].user.is? :coach  }
  get '/dashboard' => 'dashboard#index_for_player', constraints: lambda { |request| request.env['warden'].user.is? :player }
  get '/dashboard' => 'dashboard#index', as: :user_root

  resources :dashboard, only: [:index] do
    put :update_yaybar_hidden_state, on: :collection
  end

  resources :clubs, only: [] do
    collection do
      get :choose_subscription_plan
      post :activate_subscription_plan
      get :players
    end
  end

  namespace :matches do
    resources :categories, controller: 'match_categories', only: [:index] do
      collection do
        post :datatables_editor_cud
      end
    end
  end

  resources :matches, only: [:index, :show, :update], controller: 'matches/matches' do
    post :datatables_editor_cud, on: :collection
    get :edit_stats, on: :member
    get :stats, on: :member

    resources :videos, except: [:edit, :update, :show] do
      get :analyze_data, on: :member

      resources :clips, only: [:index] do
        collection do
          post :datatables_editor_cud
          post :assign_clips_to_players
        end
      end
    end
  end

  resources :clip_categories, only: [:index] do
    post :datatables_editor_cud, on: :collection
  end

  resources :playlists, only: [:index] do
    collection do
      post :datatables_editor_cud
      post :assign_playlists_to_players
    end

    resources :clips, only: [] do
      collection do
        get '/' => :index_on_playlist
        post :datatables_editor_cud_on_playlist
      end
    end
  end

  resources :clips, only: [] do
    get :for_me, on: :collection
    post :log_player_activity_on, on: :member
  end

  resources :conversations, only: [:create] do
    resources :messages, only: [:create]
  end

  resources :users, only: [:show]

  get '/players' => 'users#list_players'
end
