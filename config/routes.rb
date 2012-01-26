Rails.application.routes.draw do
  
  devise_for :account, :path=>'godmode', :class_name => 'Account', :controllers => { :sessions => 'sessions', :passwords => 'passwords'}  
  
  namespace :godmode do
    root :to => 'dashboard#index'
    resources :accounts
    
    # publications section
    resources :journal_rubrics do
      get :empty, :on => :collection
      put :sort, :on => :collection
    end
    resources :journal_articles do
      get :empty, :on => :collection
    end
    
    
    # installation guide
    match '/installation' => 'installation#show', :defaults => { :step => 1 }, :as => :installation
    match '/installation/:step' => 'installation#show', :as => :installation_step
  end
  
  root :to => 'home#index'
end
