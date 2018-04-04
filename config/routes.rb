Rails.application.routes.draw do
  namespace :api do
    scope module: :v2, constraints: ApiVersion.new('v2') do
      resources :todos, only: :index
    end
    scope module: :v1, constraints: ApiVersion.new('v1', true) do
      resources :todos do
        resources :items
      end
      get 'instagram/owner', to: 'users_instagram#index'
      get 'instagram/owner/media', to: 'users_instagram#media_recent_owner'
      get 'instagram/user/:user_id/media', to: 'users_instagram#media_recent_user'
      get 'instagram/user/media/liked', to: 'users_instagram#media_liked'
    end
  end
  post 'auth/login', to: 'authentication#login'
  delete 'auth/logout', to: 'authentication#logout'
  patch 'auth/refresh', to: 'authentication#refresh_token'
  post 'signup', to: 'users#create'
  # match '*path', via: [:options], to:  lambda {|_| [204, {'Access-Control-Allow-Headers' => "Origin, Content-Type, Accept,
  #   Authorization, Token", 'Access-Control-Allow-Origin' => "*", 'Content-Type' => 'text/plain'}, []]}
end
