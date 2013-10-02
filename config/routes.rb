Ijkh::Application.routes.draw do
  devise_for :users, :controllers => {:sessions => "sessions", :registrations => "registrations", :passwords => "passwords"}
  as :user do
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    get 'logout' => 'sessions#destroy'

    get 'registration' => 'registrations#new'
    post 'registration' => 'registrations#create'

    put '/users/:id' => 'registrations#update', as: :update_user_registration 
  end
  
  root :to => 'web_interface/main#index'

  get 'apns_test' => 'predefined_data#apns'
  post 'api/1.0/register_ios_device' => 'predefined_data#register_ios_device'

# Analytic
  get 'api/1.0/annualanalytic' => 'analytic#index'

# Place  
  get 'api/1.0/places' => 'place#index'
  post 'api/1.0/place' => 'place#create'
  put 'api/1.0/place/:place_id' => 'place#update'
  get 'api/1.0/place/city_id' => 'place#city_id_match'

# Service Type
  get 'api/1.0/servicetypes' => 'service_type#index'
  get 'api/1.0/place/:place_id/exservicetypes' => 'service_type#index_non_existant'
  post 'api/1.0/servicetype' => 'service_type#create'

# Service
  get 'api/1.0/place/:place_id/services' => 'service#index'
  get 'api/1.0/service/:service_id' => 'service#show'
  post 'api/1.0/place/:place_id/service' => 'service#create'
  post 'api/1.0/place/:place_id/userservice' => 'service#create_user_service'
  put 'api/1.0/userservice/:service_id' => 'service#update_user_service'
  delete 'api/1.0/service/:service_id' => 'service#destroy'
  get 'api/1.0/user_accounts/:vendor_id' => 'service#index_user_account'

# Card
  get 'api/1.0/cards' => 'card#index'
  delete 'api/1.0/card/:card_id' => 'card#destroy'
  
# Tariff  
  get 'api/1.0/service/:service_id/tariff' => 'tariff#index'

# Tariff Template
  get 'api/1.0/servicetype/:service_type_id/tarifftemplates' => 'tariff_template#index'
  post 'api/1.0/tariff_template' => 'tariff_template#create'

# Field Template
  get 'api/1.0/fieldtemplate' => 'field_template#index'
  post 'api/1.0/field_template' => 'field_template#create'

# Vendor
  get 'api/1.0/servicetype/:service_type_id/vendors' => 'vendor#index_with_tariffs'
  get 'api/1.0/vendors' => 'vendor#index'
  get 'api/1.0/vendor/show_by_inn' => 'vendor#show_by_inn'
  post 'api/1.0/vendor' => 'vendor#create'

# Meter Reading
  get 'api/1.0/tariff/:tariff_id/meterreadings' => 'meter_reading#index'
  get 'api/1.0/meterreadings' => 'meter_reading#index_by_vendor'
  post 'api/1.0/meterreading' => 'meter_reading#create'

# Account
  get 'api/1.0/unpaid_accounts' => 'account#unpaid_index'
  get 'api/1.0/paid_accounts' => 'account#paid_index'
  get 'api/1.0/accounts' => 'account#index'
  get 'api/1.0/detailed_accounts' => 'account#detailed_account_index'
  put 'api/1.0/service/:service_id/recurrent_account' => 'account#new_recurrent'
  put 'api/1.0/account/:account_id/switch_status' => 'account#switch_account_status' 
  put 'api/1.0/account/:account_id/holand_shturval' => 'account#hand_switch'
  delete 'api/1.0/account/:account_id' => 'account#destroy'
  post 'api/1.0/account/autoset' => 'account#autoset'

# Precinct
  get 'api/1.0/precinct/test' => 'precinct#test'
  get 'api/1.0/precinct/fetch' => 'precinct#fetch_precinct'
  get 'api/1.0/precinct/search_by_name' => 'precinct#search_by_name'
  get 'api/1.0/precinct/search_by_street' => 'precinct#search_by_street'
  get 'api/1.0/precinct/create' => 'precinct#parse_precinct'

# City
  get 'api/1.0/cities' => 'city#index'

# Service Account
  get 'api/1.0/service/:service_id/serviceaccount' => 'service_account#show'

# Recipe
  get 'api/1.0/service/:service_id/lastrecipe' => 'recipe#show_last'
  post 'api/1.0/service/:service_id/recipe' => 'recipe#create'

# Freelance Category
  get 'api/1.0/freelancecategory' => 'freelance_category#index'
  post 'api/1.0/freelance_category/create' => 'freelance_category#create'
  post 'api/1.0/freelancer/create' => 'freelancer#create'

# Non Utility Service Type
  get 'api/1.0/nonutilityservicetype' => 'non_utility_service_type#index'
  get 'api/1.0/nonutilityservicetype/:id' => 'non_utility_service_type#show'
  post 'api/1.0/nonutilityservicetype' => 'non_utility_service_type#create'
  put 'api/1.0/nonutilityservicetype/:id' => 'non_utility_service_type#update'
  delete 'api/1.0/nonutilityservicetype/:id' => 'non_utility_service_type#destroy'

# Emergency Directory
  get 'api/1.0/emergency_directory' => 'emergency_directory#index'

# Non Utility Vendor
  get 'api/1.0/nonutilityservicetype/:non_utility_service_type_id/nonutilityvendor' => 'non_utility_vendor#index_by_service_type'
  post 'api/1.0/non_utility_vendor' => 'non_utility_vendor#create'

# Non Utility Tariff
  get 'api/1.0/nonutilityvendor/:non_utility_vendor_id/nonutilitytariff' => 'non_utility_tariff#index_by_vendor'

# Payment History
  get 'api/1.0/vendor/:vendor_title/paymenthistories' => 'payment_history#index_by_vendor'
  get 'api/1.0/paymenthistories' => 'payment_history#index_by_month'
  get 'api/1.0/service/:service_id/paymenthistories' => 'analytic#get_detailed_payments'
  post 'api/1.0/payment_success' => 'payment_history#success'
  post 'api/1.0/payment_fail' => 'payment_history#fail'

# Server-Side Payment
  post 'api/1.0/payment' => 'payment#pay'
  post 'api/1.0/payment/subscribe' => 'payment#subscribe'
  post 'api/1.0/payment/secure_callback' => 'secure_callback#secure_callback'
  get 'api/1.0/payment/test' => 'payment#test'

# Report
  get 'api/1.0/report_daily' => 'report_data#index_daily'
  get 'api/1.0/report_monthly' => 'report_data#index_monthly_by_vendor'

# OSMP
  get 'osmp' => 'predefined_data#osmp'

# Web Interface
  scope '/' do
      get 'analytic' => 'web_interface/analytic#show'
      get 'faq' => 'web_interface/faq#show'
      get 'about' => 'web_interface/about#show'
      get 'offer' => 'web_interface/offer#show'
      get 'main' => 'web_interface/main#index'
      get 'payment' => 'web_interface/payment#show'
      get 'inner_offer' => 'web_interface/inner_offer#show'
      get 'profile' => 'web_interface/profile#show'
      get 'app_download' => 'web_interface/app_download#show'
      post 'get_place/:place_id' => 'web_interface/place#get_place'
      post 'get_service/:place_id' => 'web_interface/service#get_service'
      post 'get_payment_data/:service_id' => 'web_interface/payment#get_payment_data'
      post 'get_meter_reading/:tariff_id' => 'web_interface/payment#get_meter_reading'
      post 'get_recurrent_account/:service_id' => 'web_interface/payment#get_recurrent_account'
      get 'pay' => 'web_interface/payment#pay'
      post 'save_account_as_paid' => 'web_interface/payment#save_account_as_paid'
      post 'save_meter_readings' => 'web_interface/meter_reading#create'
      post 'place' => 'web_interface/place#create'
      post 'profile_place' => 'web_interface/place#profile_create'
      post 'service' => 'web_interface/service#create'
      delete 'place' => 'web_interface/place#destroy'

      get 'quiz/:quiz_token' => 'web_interface/quiz#show'
      post 'quiz/:user_id' => 'web_interface/quiz#create'
      
      get "catalog" => "web_interface/catalog#show"
      get "emergency" => "web_interface/emergency#show"
      get "freelancers" => "web_interface/freelancers#show"
      put 'delete_service/:service_id' => 'web_interface/service#delete'

      get "redirect" => 'web_interface/redirect_page#show'

      match 'feedback' => 'web_interface/feedback#new', :as => 'feedback', :via => :get
      match 'feedback' => 'web_interface/feedback#create', :as => 'feedback', :via => :post

      match 'quiz_feedback' => 'web_interface/quiz#create', :as => 'quiz_feedback', :via => :post

      match 'quiz_results_view' => 'web_interface/quiz_results_view#show', :as => 'quiz_results_view', :via => :get
      match 'quiz_mailing' => 'web_interface/quiz_mailing#show', :as => 'quiz_mailing', :via => :get
      match 'quiz_mailing' => 'web_interface/quiz_mailing#create', :as => 'quiz_mailing', :via => :post
      match 'quiz_mailchimp' => 'web_interface/quiz_mailing#mailchimp', :as => 'quiz_mailchimp', :via => :post



      

  end
  
  namespace :web_interface do
    resources :place, only: [:index, :create, :update] do
        put :deactivate, on: :member
    end

    resources :quiz_results
  end


end
