Rails.application.routes.draw do
  
  devise_for :account, :path=>'godmode', :class_name => 'Account', :controllers => { :sessions => 'sessions', :passwords => 'passwords'}  
  
  namespace :godmode do
    root :to => 'dashboard#index'
    get 'switch_to/:role' => 'dashboard#switch_to', :as => :role_switch
    
    resources :accounts do
      get :articles,      :on => :member
    end
    
    # publications section
    resources :journal_rubrics do
      get :empty,         :on => :collection
      put :sort,          :on => :collection
    end
    resources :journal_articles do
      get :empty,         :on => :collection
      get :prepublished,  :on => :collection
      get :published,     :on => :collection
    end
    
    namespace :mediabank do
      root :to => 'media_collections#index'
      resources :media_collections do
        get :add_files, :on => :member
        resources :media_files
      end
    end
    
    
    # installation guide
    match '/installation' => 'installation#show', :defaults => { :step => 1 }, :as => :installation
    match '/installation/:step' => 'installation#show', :as => :installation_step
  end
  
  root :to => 'home#index'
end
