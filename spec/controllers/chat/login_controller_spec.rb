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

    context 'when user does not exist' do
      it 'creates a session for the user' do
        expect do
          get :create, parameters
        end.to change { Chat::Session.count }.by(1)
        expect(Chat::Session.last.user).to eq(User.last)
        expect(Chat::Session.last.room).to eq(room)
      end
    end

    context 'when user exists' do
      context 'when there is no session for the given user and room' do
        let(:user) { users(:user1) }
        let(:email) { user.email }

        it 'creates a session for the user' do
          expect do
            get :create, parameters
          end.to change { Chat::Session.count }.by(1)
          expect(Chat::Session.last.user).to eq(user)
          expect(Chat::Session.last.room).to eq(room)
        end
      end

      context 'when there is a session for the given user and room' do
        let(:user) { users(:with_chat_session) }
        let(:email) { user.email }

        it 'does not create a session for the user' do
          expect do
            get :create, parameters
          end.not_to change { Chat::Session.count }
        end
      end
    end
  end
end
