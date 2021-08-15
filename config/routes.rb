Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :v1 do
    post "register/" => "users#register"
    post "login/" => "logistrations#login"
    post "logout/" => "logistrations#logout"

    resources :todos
  end
end
