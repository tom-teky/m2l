Credit::Application.routes.draw do
  get "welcome/index"

  devise_for :accounts
  resource :me, only: [:update, :edit, :show]
  resources :targets, only: :index do
    resources :transactions, only: [:new, :create]
  end
  resources :transactions, only: :index
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
end
