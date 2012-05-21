Rails.application.routes.draw do

  devise_for :account, :class_name => 'Account', :controllers => { :sessions => 'sessions', :passwords => 'passwords', :registrations => 'registrations'}

  namespace :godmode do
    root :to => 'dashboard#index'
    get 'switch_to/:role' => 'dashboard#switch_to', :as => :role_switch

    resources :memberships, :only => [:edit, :update]
    resources :accounts do
      get :articles,      :on => :member
      post :change_user, :on => :member
    end
    resources :columns
    resources :column_articles do
      get :empty,         :on => :collection
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
      get :tags,          :on => :collection
    end

    resources :faces do
      get :empty,         :on => :collection
      get :prepublished,  :on => :collection
      get :published,     :on => :collection
      get :tags,          :on => :collection
    end

    namespace :mediabank do
      root :to => 'media_collections#index'
      resources :media_collections do
        get :add_files, :on => :member
        get :descriptions, :on => :member
        resources :media_files do
          put :sort,          :on => :collection
        end
      end
    end


    # installation guide
    match '/installation' => 'installation#show', :defaults => { :step => 1 }, :as => :installation
    match '/installation/:step' => 'installation#show', :as => :installation_step
  end

  root :to => 'home#index'
  match '/test_search' => 'home#search_path', :as => :test_search

  namespace :journal do
    root :to => "journal_rubrics#index"
  end
  namespace :columns do
    root :to => "columns#index"
  end

  namespace :timeline do
    match "/(:date)" => "timelines#index",
      :as => :root,
      :constraints => { :date => /\d{4}-\d{2}-\d{2}/ }
  end

  scope "/face-patrol", :module => "face_patrol", :as => "face_patrol" do
    root :to => "face_patrols#index"
    match 'gallery' => "face_patrols#gallery", :as => :gallery
  end

  resources :comments, :only =>[] do
    member do
      get :form
      post :post
    end
  end

  resource :profile, :only => [:show, :edit] do
    put :update
  end
  match '/404' => 'rendering#page_not_found'

  # Any rendering
  get '*path' => 'rendering#show'
  post '*path' => 'rendering#comment'
end
