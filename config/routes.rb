# encoding: utf-8

MoneyTracker::Application.routes.draw do
  root to: "transactions#index"
  resources :transactions, only: [:index, :edit, :update] do
    collection do
      get :search
    end
  end
  resources :uploads,      only: [:new, :create]
  resources :categories,   only: [] do
    collection do
      get :search
    end
  end
  resources :descriptions, only: [] do
    collection do
      get :search
    end
  end
end
