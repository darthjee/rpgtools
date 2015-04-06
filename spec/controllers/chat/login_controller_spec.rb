require 'spec_helper'

describe Chat::LoginController do
  describe 'create' do
    let(:email) { 'new_user@server.com' }
    let(:user_nick) { 'john' }
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

        context 'when sending the same nick' do
          it 'does not create a session for the user' do
            expect do
              get :create, parameters
            end.not_to change { Chat::Session.count }
          end
        end

        context 'when sending a new nick' do
          let(:chat_session) { chat_sessions(:default_with_session) }
          let(:id) { chat_session.id }
          let(:user_nick) { 'new_john' }

          it 'does not create a session for the user' do
            expect do
              get :create, parameters
            end.not_to change { Chat::Session.count }
          end

          it 'alters the user session with the given nick' do
            expect do
              get :create, parameters
            end.to change { Chat::Session.find(id).nick }
          end
        end
      end
    end
  end
end
