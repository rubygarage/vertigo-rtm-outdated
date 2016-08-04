Rails.application.routes.draw do
  root 'welcome#index'

  resources :sessions, only: [:new, :create]
  delete :session, to: 'sessions#destroy', as: :destroy_session

  mount ActionCable.server => '/cable'
  mount Vertigo::Rtm::Engine => '/vertigo-rtm'
end
