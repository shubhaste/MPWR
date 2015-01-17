Rails.application.routes.draw do
  get 'attachment/pdf'

  resources :companies

  get 'home/index'

 # devise_for :users, :path_names => {:sign_in => "login", :sign_out => "logout"}, :path => "users"
 devise_for :users, :controllers => { :registrations => 'registrations'},:path_names => {:sign_in => "login", :sign_out => "logout"}, :path => "users"
  #resources :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

  #get "customer_lookups/list_all" => "customer_lookups#list_all"
  get "customer_lookups/list_all" => "customer_lookups#list_all"
  get "customer_lookups/search" => "customer_lookups#search"
  get "pending_approve/list_all" => "pending_approve#list_all"
  
  root to: "home#index"
  
  resources :users

resources :companies do
    resources :certificates do
       member do
        #post :director_reject,:as => 'director_reject'
        #post :director_accept,:as => 'director_accept' 
        #post :minister_reject,:as => 'minister_reject'
        #post :minister_accept,:as => 'minister_accept'
        #post :revoke,:as => 'revoke' 
        #post :reinstate,:as => 'reinstate'
        get :issue_license,:as => 'issue_license' 
        get :ready_approval,:as => 'ready_approval' 
      end
    end
    resources :attachments,:only => :pdf  do
      member do
        get :pdf,:as => 'pdf'
      end  
    end
    resources :owners,:only => [:passport_pdf,:national_pdf]  do
      member do
        get :passport_pdf,:as => 'passport_pdf'
        get :national_pdf,:as => 'national_pdf'
      end  
    end
  end

  match '*a' => 'errors#routing' ,:via => [:get,:post,:delete,:patch,:post]

end
