MoneyTracker::Application.routes.draw do
  root :to => "transactions#index"
  resources :transactions, :only => [:index, :update] do
    collection do
      get :search
    end
  end
  resources :uploads,      :only => [:new, :create]
end
