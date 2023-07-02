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
    get '/all_tasks', to: 'tasks#index'
    get '/task_detail', to: 'tasks#show'
    post '/create_task', to: 'tasks#create'
    delete '/delete_task', to: 'tasks#destroy'

    get '*path', to: 'application#not_found'
  end
end
