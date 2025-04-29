Rails.application.routes.draw do
  root to: 'projects#index'
  resources :projects do
    resources :tasks
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
