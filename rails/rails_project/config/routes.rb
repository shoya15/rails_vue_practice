Rails.application.routes.draw do
  scope :api do
    get '/get_csrf_token', to: 'csrf_tokens#show'
    
    # ユーザー
    get '/check_signed_in', to: 'sessions#check_signed_in'
    post '/sign_up', to: 'users#create'
    post '/sign_in', to: 'sessions#create'
    delete '/sign_out', to: 'sessions#destroy'

    # タスク
    get '/tasks', to: 'tasks#index'
    post '/tasks', to: 'tasks#create'
    put '/tasks/:id', to: 'tasks#update'

    # フォロー
    get '/followings', to: 'relationships#index'
    post '/follow', to: 'relationships#create'
    delete '/unfollow/:id', to: 'relationships#destroy'

    # いいね
    get '/favorites', to: 'favorites#index'
    post '/favorites', to: 'favorites#create'
    delete '/favorites/:id', to: 'favorites#destroy'
    get '/favorites_count', to: 'tasks#favorites_count'

    get '*path', to: 'application#not_found'
  end
end
