Rails.application.routes.draw do
  resources :tasks
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
    get '/tasks/:id', to: 'tasks#show'
    post '/tasks', to: 'tasks#create'
    put '/tasks/:id', to: 'tasks#update'

    get '*path', to: 'application#not_found'
  end
end
