App::Application.routes.draw do
  namespace :api do
     resources :sessions, only: [] do
        collection do
           post 'login'
           delete 'logout'
        end
     end
     resources :products, only: [] do
       get 'top_products_by_category', on: :collection
       get 'top_best_sellers_by_category', on: :collection
     end

     resources :purchases, only: [:index] do
       get 'granularity_report', on: :collection
     end
  end
end
