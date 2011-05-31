MoneyTracker::Application.routes.draw do
  root :to => "transactions#index"
  resources :transactions, :only => [:index, :edit, :update] do
    collection do
      get :search
    end
  end
  resources :uploads,      :only => [:new, :create]
end
