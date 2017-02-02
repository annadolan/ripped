Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :exercises, only: [:index, :show] do
    resources :solutions, only: [:show, :new, :create]
  end


end
