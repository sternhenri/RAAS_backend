Rails.application.routes.draw do

  #sessions
  # post '/users/create', to: 'registrations#create'
  get '/referrals/configure', to: 'referrals#configure'
  get '/referrals/initiate', to: 'referrals#get_code'
  post '/referrals/sent', to: 'referrals#code_sent'
  get '/referrals/:company_name/:code', to: 'referrals#code_hit'
  put '/referrals/download', to: 'referrals#record_download'
  put '/referrals/registration', to: 'referrals#record_registration'

  get '/user_stats', to: 'client#user_stats'
  get '/referral_stats', to: 'client#referral_stats'
  get '/settings', to: 'client#settings'
  put '/settings', to: 'client#changeSettings'

  root to: 'home#index'

end
