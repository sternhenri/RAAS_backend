Rails.application.routes.draw do

  #sessions
  post '/users/create', to: 'registrations#create'
  post '/users/upload', to: 'users#upload_profile_pic'
  put '/users/send_reset_password', to: 'registrations#send_reset_password'
  put '/users/reset_password', to: 'registrations#reset_password'
  post '/users/session', to: 'sessions#create'
  delete '/users/session', to: 'sessions#destroy'

  #users
  post '/users/upload_device_token', to: 'users#upload_device_token'
  get '/users/notifications', to: 'users#fetch_notifications'
  get '/users/calendar_info', to: 'users#calendar_info'
  get '/users/info', to: 'users#info'
  get '/users/tags', to: 'users#tags'
  get '/users/pro_tip', to: 'users#pro_tip'
  put '/users/set_push_token', to: 'users#set_push_token'

  post '/users/connect_twitter', to: 'registrations#connect_twitter'

  #timeline - private methods
  get '/posts/timeline', to: 'timeline#posts'
  get '/posts/today', to: 'timeline#current_day_posts'
  get '/posts/filtered_with_tags', to: 'timeline#tag_filtered_search'

  #timeline - public methods
  get '/posts/public', to: 'timeline#public'
  get '/posts/feed_list', to: 'timeline#feed_list'
  get '/posts/unread', to: 'timeline#unread_posts'

  post '/posts/like', to: 'timeline#like'
  post '/posts/skip', to: 'timeline#pass'
  get '/posts/likes', to: 'timeline#post_likes'

  #posts
  post '/posts', to: 'posts#create'
  post '/posts/save', to: 'posts#save'
  delete '/posts/soft_delete', to: 'posts#soft_delete'
  post '/posts/tweet', to: 'posts#tweet'
  get '/posts/tweet', to: 'posts#send_tweet'
  put '/posts/make_public', to: 'posts#make_public'
  put '/posts/make_private', to: 'posts#make_private'

  #Angular
  root to: 'home#index'
  get '/test/okay', to: 'home#test'
  get "*path.html" => "home#index", :layout => 0
  match "*path" => "home#index", via: :all

end
