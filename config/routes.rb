Rails.application.routes.draw do
  devise_for :user_accounts, singular: :user_account, class_name: 'User::AccountRecord'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/"
  root to: 'home#index'

  namespace :workload do
    resources :points, only: %i[index create]
    resources :aggregations, only: %i[index]
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
