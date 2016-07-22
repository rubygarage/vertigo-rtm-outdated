Rails.application.routes.draw do
  mount Vertigo::Rtm::Engine => "/vertigo-rtm"
end
