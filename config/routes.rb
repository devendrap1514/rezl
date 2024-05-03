require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  authenticate :admin_user do
    mount Sidekiq::Web => '/admin/sidekiq'
  end

  # post '/webhooks/calendly', to: 'webhooks#calendly'

  resources :term_and_conditions, only: %i[index] do
    collection do
      post :accept_terms
    end
  end
end
