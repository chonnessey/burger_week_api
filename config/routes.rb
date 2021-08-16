Rails.application.routes.draw do
  resources :burgers do
    resources :reviews
  end
end
