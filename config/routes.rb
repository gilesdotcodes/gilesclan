Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  resources :biography_events, path: 'biography'
  resources :person_tags, only: [:new, :create]
  resources :type_tags, only: [:new, :create]
  resources :portugal_events, only: [:new, :create, :index, :destroy] do
    collection do
      get :view_date
    end
  end

  # for testing mailers only
  post 'random', to: 'biography_events#random'
  post 'daily', to: 'biography_events#daily'
  post 'summary', to: 'biography_events#summary'

  root 'base#index'
end
