Rails.application.routes.draw do
  namespace :api do
    scope module: :v2, constraints: ApiVersion.new('v2') do
      resources :todos, only: :index
    end
    scope module: :v1, constraints: ApiVersion.new('v1', true) do
      resources :todos do
        resources :items
      end
    end
  end
  post 'auth/login', to: 'authentication#login'
  post 'signup', to: 'users#create'
  # match '*path', via: [:options], to:  lambda {|_| [204, {'Access-Control-Allow-Headers' => "Origin, Content-Type, Accept,
  #   Authorization, Token", 'Access-Control-Allow-Origin' => "*", 'Content-Type' => 'text/plain'}, []]}
end
