Rails.application.routes.draw do
  apipie
  mount Vertigo::Rtm::Engine => "/vertigo-rtm"
end
