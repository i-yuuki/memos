Rails.application.routes.draw do
  root to: 'memos#index'
  resources :memos do
    resources :comments
  end
  resource  :session
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
