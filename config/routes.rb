Rails.application.routes.draw do
  mount MissionControl::Jobs::Engine, at: "/jobs"

  root to: 'projects#index'
  resources :projects do
    resources :tasks
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
