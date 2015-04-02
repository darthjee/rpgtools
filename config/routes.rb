Rails.application.routes.draw do
  scope module: :chat, path: 'chat' do
    resources :rooms, only: [:show] do
      resources :messages, only: [:create]
    end
  end


  resources :login, only: [:index, :create]
end
