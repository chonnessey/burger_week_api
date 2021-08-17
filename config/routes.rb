Rails.application.routes.draw do
  resources :burgers do
    collection do
      get 'dealz'
    end
    resources :reviews
  end
  # get 'burgers/dealz' => 'users#new'
end
