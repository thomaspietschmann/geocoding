Rails.application.routes.draw do
  resources :flats

  patch "/flats/:id/confirm",         to: "flats#confirm",    as: :confirm_flat

  root to: "flats#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
