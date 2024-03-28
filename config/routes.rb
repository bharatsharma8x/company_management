Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :employees do
    resources :leave_managements do
      member do
        patch 'approve'
        patch 'reject'
      end
    end
    resources :bank_accounts
    get 'filter_by_department', on: :collection
    get 'sort', on: :collection

  end

  resources :leave_managements do
    collection do
      get 'pending_leaves'
    end
  end

  resources :departments
  resources :periferals
  resources :allocates
  resources :salaries do
    collection do
      post 'calculate_salary'
    end
  end
  resources :attendances do
    collection do
      post 'import'
    end
  end
end
