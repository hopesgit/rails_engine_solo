Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end
      resources :items, only: [:index, :show, :create, :update, :destroy]
      namespace :items do
        get '/:id/merchant', to: 'merchants#index'
      end
    end
  end
end
