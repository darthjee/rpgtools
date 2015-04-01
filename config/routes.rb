Rails.application.routes.draw do
  scope module: :chat, path: 'chat' do
    resources :rooms, only: [:show]
  end
end
