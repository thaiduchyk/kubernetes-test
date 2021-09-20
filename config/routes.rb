require "sidekiq/web"

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Sidekiq::Web => "/sidekiq"

  root 'application#version'
  get 'version', to: 'application#version'

  namespace :admin do
  	resources :orders, except: :destroy
    resources :jobs, only: :create
  end
end
