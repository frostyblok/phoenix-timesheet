Rails.application.routes.draw do
  resources :employees, only: [:create] do
    resources :time_sheets, except: [:index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
