require 'spec_helper'

describe Chat::Session do
  let(:room) { chat_rooms(:default) }
  let(:user) { users(:user1) }
  let(:nick) { 'new_nick' }
  let(:attributes) do
    {
      user: user,
      room: room,
      nick: nick
    }
  end

  describe '.create_or_update' do
    context 'when session does not exist' do
      let(:created_session) { Chat::Session.last }
      it 'creates a session for the user' do
        expect do
          Chat::Session.create_or_update attributes
        end.to change { Chat::Session.count }.by(1)
        expect(created_session.user).to eq(user)
        expect(created_session.room).to eq(room)
        expect(created_session.nick).to eq(nick)
      end
    end

    context 'when session exists' do
      let(:user) { users(:with_chat_session) }

      context 'with the same nick' do
        let(:nick) { 'john' }

        it 'does not creates a session for the user' do
          expect do
            Chat::Session.create_or_update attributes
          end.not_to change { Chat::Session.count }
        end
      end

      context 'with a new nick' do
        let(:session) { chat_sessions(:default_with_session) }

        it 'does not creates a session for the user' do
          expect do
            Chat::Session.create_or_update attributes
          end.not_to change { Chat::Session.count }
        end

        it 'alters the current session' do
          expect do
            Chat::Session.create_or_update attributes
          end.to change { Chat::Session.find(session.id).nick }
        end
      end
    end
  end
end
