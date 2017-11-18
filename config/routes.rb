Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :todos do
    post "done"
  end
  resources :categories do
    resources :todos do
      post "done"
    end
  end
end
