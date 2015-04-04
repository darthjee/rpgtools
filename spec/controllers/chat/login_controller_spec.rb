require 'spec_helper'

describe Chat::LoginController do
  describe 'create' do
    let(:email) { 'new_user@server.com' }
    let(:user_nick) { 'user_nick' }
    let(:redirect_path) { '/new_path' }
    let(:room) { chat_rooms(:default) }
    let(:parameters) do
      {
        chat_session: {
          nick: user_nick,
          user: { email: email }
        },
        room_id: room.key,
        redirect_to: redirect_path
      }
    end

    it_behaves_like 'a controller that handles user login'
  end
end
