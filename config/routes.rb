Rails.application.routes.draw do
  # get 'periferals/index'
  # get 'periferals/new'
  # get 'periferals/create'
  # get 'periferals/edit'
  # get 'periferals/update'
  # get 'periferals/destroy'
  # get 'periferals/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # get "/employees" , to: "employees#index"
    root "employees#index"
    resources :employees
    resources :departments
    resources :periferals
end
