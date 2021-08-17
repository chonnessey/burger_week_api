Rails.application.routes.draw do
  resources :burgers do
    collection do
      get 'dealz'
      get 'most_five'
      get 'top_five'
      get 'rando'
    end
    resources :reviews
  end
  # get 'burgers/dealz' => 'users#new'
end
