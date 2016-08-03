Vertigo::Rtm::Engine.routes.draw do
  resources :users, only: [:index, :update]

  resource :preference, only: [:show, :update]

  resources :conversations, only: :index do
    resource :preference, only: [:show, :update]
    resources :messages, only: [:index, :create, :update, :destroy]
    resources :files, only: :index
  end

  resources :channels, only: [:create, :show, :update] do
    member do
      put :leave
      put :kick
      put :invite
      put :archive
      put :unarchive
    end
  end

  resources :groups, only: [:create, :show]
end
