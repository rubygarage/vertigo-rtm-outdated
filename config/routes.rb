Vertigo::Rtm::Engine.routes.draw do
  resources :users, only: [:index, :update] do
    resource :preference, only: [:show, :update]
  end

  resources :conversations, only: :index do
    resource :preference, only: [:show, :update]
    resources :messages, only: [:index, :create, :update, :destroy]
    resources :files, only: :index
  end

  resources :channels, only: [:create, :show, :update, :destroy] do
    member do
      put :leave
      put :kick
      put :invite
    end
  end

  resources :groups, only: [:create, :show, :destroy]
end
