Rails.application.routes.draw do
  scope :api do
    get '/get_csrf_token', to: 'csrf_tokens#show'

    get '/sample_items', to: 'sample_items#index'
    post '/sample_items', to: 'sample_items#create'

    post '/sign_up', to: 'users#create'
    post '/sign_in', to: 'sessions#create'
    delete '/sign_out', to: 'sessions#destroy'

    get '*path', to: 'application#not_found'
  end
end
