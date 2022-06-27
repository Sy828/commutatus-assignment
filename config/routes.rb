Rails.application.routes.draw do 
  resources :dashboards
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #root to: "static#dashboard"
  root to: "dashboards#index"
  get 'people/:id', to: 'static#person'


  resources :users do
    collection do
      post :add_friends
    end
  end

  resources :expenses do
    collection do
      post :save_expenses
      post :settle_up_dues
      post :fetch_amoun_to_pay
    end
  end


end
