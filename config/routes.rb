Rails.application.routes.draw do

  resources :includeds do
    member do
      put 'include', to: 'includeds#include'
      put 'exclude', to: 'includeds#exclude'
      get 'csv', to: 'includeds#csv'
    end
  end

  resources :springers do
    member do
      put 'select', to: 'springers#select'
      put 'unselect', to: 'springers#unselect'
    end
  end
  resources :scopus do
    member do
      put 'select', to: 'scopus#select'
      put 'unselect', to: 'scopus#unselect'
    end
  end
  resources :scidirs do
    member do
      put 'select', to: 'scidirs#select'
      put 'unselect', to: 'scidirs#unselect'
    end
  end
  resources :acms do
    member do
      put 'select', to: 'acms#select'
      put 'unselect', to: 'acms#unselect'
    end
  end
  resources :ieees do
    member do
      put 'select', to: 'ieees#select'
      put 'unselect', to: 'ieees#unselect'
    end
  end

  resources :springers_users_protocols do
    member do
      put 'select', to: 'springers_users_protocols#select'
      put 'unselect', to: 'springers_users_protocols#unselect'
      put 'include', to: 'springers_users_protocols#include'
      put 'exclude', to: 'springers_users_protocols#exclude'
      put 'maybe', to: 'springers_users_protocols#maybe'
      get 'csv', to: 'springers_users_protocols#csv'
    end
  end
  resources :scopus_users_protocols do
    member do
      put 'select', to: 'scopus_users_protocols#select'
      put 'unselect', to: 'scopus_users_protocols#unselect'
      put 'include', to: 'scopus_users_protocols#include'
      put 'exclude', to: 'scopus_users_protocols#exclude'
      put 'maybe', to: 'scopus_users_protocols#maybe'
      get 'csv', to: 'scopus_users_protocols#csv'
    end
  end
  resources :scidirs_users_protocols do
    member do
      put 'select', to: 'scidirs_users_protocols#select'
      put 'unselect', to: 'scidirs_users_protocols#unselect'
      put 'include', to: 'scidirs_users_protocols#include'
      put 'exclude', to: 'scidirs_users_protocols#exclude'
      put 'maybe', to: 'scidirs_users_protocols#maybe'
      get 'csv', to: 'scidirs_users_protocols#csv'
    end
  end
  resources :acms_users_protocols do
    member do
      put 'select', to: 'acms_users_protocols#select'
      put 'unselect', to: 'acms_users_protocols#unselect'
      put 'include', to: 'acms_users_protocols#include'
      put 'exclude', to: 'acms_users_protocols#exclude'
      put 'maybe', to: 'acms_users_protocols#maybe'
      get 'csv', to: 'acms_users_protocols#csv'
    end
  end
  resources :ieees_users_protocols do
    member do
      put 'select', to: 'ieees_users_protocols#select'
      put 'unselect', to: 'ieees_users_protocols#unselect'
      put 'include', to: 'ieees_users_protocols#include'
      put 'exclude', to: 'ieees_users_protocols#exclude'
      put 'maybe', to: 'ieees_users_protocols#maybe'
      get 'csv', to: 'ieees_users_protocols#csv'
    end
  end

  resources :users_protocols do
    member do
      put 'submit'
      get 'show_conflicts'
      get 'included'
    end
  end

  resources :references do
    collection do
      post 'distribute'
    end
  end

  resources :protocols do
    member do
      # Using member you create a route for that specific protocol, e.g. 'protocols/5/search'
      # Otherwise, using collection you can create a route without a specific id :)
      get 'search'
      post 'do_search'
      get 'selected'
      get 'included'
      get 'distribute_studies', to: 'references#distribute_studies'
    end
  end

  get 'terms_of_service', to: 'home#terms_of_service'
  get 'privacy_policy', to: 'home#privacy_policy'
  get 'community_rules', to: 'home#community_rules'
  get 'user_manual', to: 'home#user_manual'

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'protocols#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
