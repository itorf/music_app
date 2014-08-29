MusicApp::Application.routes.draw do
  root to: 'bands#index'
  resources :users
  resource :session
  resources :bands do
    resources :albums, only: :new
  end
  
  resources :albums, except: [:new, :index] do
    resources :tracks, only: :new
  end
  
  resources :tracks, except: [:new, :index]
end
