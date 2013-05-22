Ijkh::Application.routes.draw do
  devise_for :users, :controllers => {:sessions => "sessions", :registrations => "registrations"}
  as :user do
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    get 'logout' => 'sessions#destroy'

    get 'registration' => 'registrations#new'
    post 'registration' => 'registrations#create'
  end
  root :to => 'web_interface/main#index'

# Analytic
  get 'api/1.0/annualanalytic' => 'analytic#index'

# Place  
  get 'api/1.0/places' => 'place#index'
  post 'api/1.0/place' => 'place#create'
  put 'api/1.0/place/:place_id' => 'place#update'

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

# Card
  get 'api/1.0/cards' => 'card#index'
  delete 'api/1.0/card/:card_id' => 'card#destroy'
  
# Tariff  
  get 'api/1.0/service/:service_id/tariff' => 'tariff#index'

# Tariff Template
  get 'api/1.0/servicetype/:service_type_id/tarifftemplates' => 'tariff_template#index'

# Field Template
  get 'api/1.0/fieldtemplate' => 'field_template#index'

# Vendor
  get 'api/1.0/servicetype/:service_type_id/vendors' => 'vendor#index_with_tariffs'

# Meter Reading
  get 'api/1.0/tariff/:tariff_id/meterreadings' => 'meter_reading#index'
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

# Service Account
  get 'api/1.0/service/:service_id/serviceaccount' => 'service_account#show'

# Recipe
  get 'api/1.0/service/:service_id/lastrecipe' => 'recipe#show_last'
  post 'api/1.0/service/:service_id/recipe' => 'recipe#create'

# Freelance Category
  get 'api/1.0/freelancecategory' => 'freelance_category#index'

# Non Utility Service Type
  get 'api/1.0/nonutilityservicetype' => 'non_utility_service_type#index'
  post 'api/1.0/nonutilityservicetype' => 'non_utility_service_type#create'

# Payment History
  get 'api/1.0/service/:service_id/paymenthistories' => 'analytic#get_detailed_payments'
  post 'api/1.0/payment_success' => 'payment_history#success'
  post 'api/1.0/payment_fail' => 'payment_history#fail'

# Web Interface
  scope '/' do
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
      post 'get_recurrent_account/:tariff_id' => 'web_interface/payment#get_recurrent_account'
      post 'save_meter_readings' => 'web_interface/meter_reading#create'
      post 'place' => 'web_interface/place#create'
      post 'service' => 'web_interface/service#create'

  end


end
