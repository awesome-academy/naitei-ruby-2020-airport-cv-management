Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "login" => "sessions#new"
    post    "login"    => "sessions#create"
    delete  "logout"   => "sessions#destroy"
    resources :users
  end
end
