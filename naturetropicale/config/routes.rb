Rails.application.routes.draw do
  devise_for :users,path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'inscription' }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users_devise/unlocks',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  authenticate do
    root to: 'home#index'
    get 'profile-validation', to: 'home#waiting_for_validation'
    get 'mon-calendrier', to: 'home#calendar'
    get 'billing', to: 'paiements#billing'
    # get 'paiement', to: 'home#remuneration'
    namespace :admin do
      get 'dashboard/index'
      resources :job_categories
      resources :users, except: :show do
        member do
          post 'reject_profile'
          post 'update_users_roles'
        end
      end
    end
    
    resources :profiles do
      get "enterprise_profile"
      member do
        post "post_profile"
        post "enterprise_profile"
        post 'activate_profile'
        post 'disabled_profile'
        post 'create_paiement'
        post 'confirmation_paiement'
        post 'canceled_paiement'
        post 'pay_bill'
        get  'paiement_history'
      end
      # collection do
      #   post 'confirmation_paiement'
      # end
    end
    resources :jobs do
      collection do
        get "drafts", to: 'jobs#draft_jobs'
        get 'job_for_enterprise', to: 'jobs#admin_job'
        get  'proposals_list', to: 'jobs#proposals_list'
        get 'job_paiement', to: 'jobs#facturation'
        # post 'enterprise_profile'
        # get 'enterprise_profile', to: 'profiles#enterprise_profile'
      end
      member do
        post 'job_finished'
        post 'invitation_to'
        post 'assign_to'
        post 'set_price'
        get 'users_course'
      end
    end

    resources :post_categories
    resources :reviews
    namespace :admin do
      namespace :location do
        resources :villes
        resources :regions
        resources :provinces
      end
      get 'paiement', to: 'paiements#index'
      get 'paiement', to: 'paiements#show'
    end
    resources :proposals do
      member do
        post 'accept_proposal'
        post 'reject_proposal'
      end
    end
  end
  namespace :api do
    namespace :v1 do
     resources :jobs
     resources :proposals
     resources :profiles do
      member do
        post 'confirmation_paiement'
      end
       collection do
        get 'paiement', to: 'profiles#paiement'
       end
     end

     resources :paiement do
       member do
         post 'paiement',to: 'paiements#mypaiements'
       end
     end
     
     resources :categories
     resources :regions
     resources :villes
     resources :provinces
     resources :multiprofiles
     devise_scope :user do
      post "sign_up", to: "registrations#create"
      post "sign_in", to: "sessions#create"
      post "reset", to: "registrations#reset"
      post "forgot", to: "registrations#forgot"
     end
    end
  end

  unauthenticated do
    get 'welcome_to_naturetropicale', to: 'home#welcome_to_naturetropicale'
  end

  #routes to errors
  match "/404", :to => 'errors#not_found', :via => :all
  match "/500", :to => 'errors#internal_error', :via => :all
end
