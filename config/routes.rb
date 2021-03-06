Rails.application.routes.draw do
  resources :voices
  resources :interventions
  devise_for :users
  
  resources :quotes
  resources :leads
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Authenticates Blazer Using Devise
  authenticate :user, ->(user) { user.superadmin_role? or user.employee_role? } do
    mount Blazer::Engine, at: "blazer"
  end

  # # If Above Doesn't Work Then Uncomment Below:
  # mount Blazer::Engine, at: "blazer"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#index"
  get "residential" => "pages#residential"
  get "commercial" => "pages#commercial"
  get "quotes" => "pages#quote"

  get "/index" => "pages#index"

  #get 'welcome' => 'watson#welcome'

  get '/watson/update' => 'watson#speak'
  
  get "/interventions" => "pages#interventions"

  # /quotes is the action from the form in quote.html.erb
  post "/quotes" => "quotes#create"

  # /leads is the action from the form in index.html.erb
  post "/leads" => "leads#create"

  get "/ajax/GetData" => "interventions#getData"

  get 'speech', to: 'voices#index'
  get 'speech/recognizer', to: 'voices#recognizer'
  get 'verify_audio', to: 'voices#verify_audio'
  post 'upload_audio', to: 'voices#upload_audio'
  get 'create_profile_id', to: 'voices#create_profile_id'
  get 'enroll_profile', to: 'voices#enroll_new_profile'

  get 'speechtext', to: 'voices#speechtext'
  get 'recognizer', to: 'voices#recognizer'
end
