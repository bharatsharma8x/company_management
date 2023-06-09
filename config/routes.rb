Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :employees do
    resources :bank_accounts
    get 'filter_by_department', on: :collection
    get 'sort', on: :collection

  end

  resources :departments
  resources :periferals
  resources :allocates
  resources :attendances
  resources :salaries
end
