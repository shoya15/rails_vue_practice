Rails.application.routes.draw do
  scope :api do
    get '/get_csrf_token', to: 'csrf_tokens#show'

    # サンプル
    get '/sample_items', to: 'sample_items#index'
    post '/sample_items', to: 'sample_items#create'

    # ユーザー
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

    # ファイト(いいね)
    get '/favorites', to: 'favorites#index'
    post '/favorites', to: 'favorites#create'
    delete '/favorites/:id', to: 'favorites#destroy'

    get '*path', to: 'application#not_found'
  end
end
