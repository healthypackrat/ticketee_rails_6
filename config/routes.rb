Rails.application.routes.draw do
  namespace :admin do
    root "application#index"

    resources :projects, only: [:new, :create, :destroy]

    resources :users do
      member do
        patch :archive
      end
    end

    resources :states, only: [:index, :new, :create] do
      member do
        get :make_default
      end
    end
  end

  devise_for :users

  root "projects#index"

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets do
      collection do
        get :search
        post :upload_file
      end

      member do
        patch :watch
      end
    end
  end

  scope path: "tickets/:ticket_id", as: :ticket do
    resources :comments, only: [:create]
    delete "tags/remove/:id", to: "tags#remove", as: :remove_tag
  end
end
