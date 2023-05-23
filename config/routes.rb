Rails.application.routes.draw do

    root "home#index"

    resources :employees do
      resources :bank_accounts
      get 'filter_by_department', on: :collection
    end


    resources :departments
    resources :periferals
    resources :allocates

end
