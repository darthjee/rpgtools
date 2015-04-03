Rails.application.routes.draw do
  scope as: :chat, module: :chat, path: 'chat' do
    resources :rooms, only: [:show] do
      resources :messages, only: [:create]
      resources :login, only: [:index, :create]
    end
  end

  resources :login, only: [:index, :create]
end
