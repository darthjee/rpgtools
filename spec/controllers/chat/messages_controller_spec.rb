require 'spec_helper'

describe Chat::MessagesController do
  let(:room) { chat_rooms(:default) }

  describe 'create' do
    let(:user) { users(:with_chat_session) }
    let(:text) { 'test text' }
    let(:created_message) { Chat::Message.last }
    let(:parameters) do
      {
        room_id: room.key,
        chat_message: {
          text: text,
          action: :say
        }
      }
    end

    before { controller.sign_in(user) }

    it 'creates a message for the user on the room' do
      expect do
        post :create, parameters
      end.to change { Chat::Message.count }.by(1)
      expect(created_message.session.user).to eq(user)
      expect(created_message.room).to eq(room)
    end

    it 'does not create a new session' do
      expect do
        post :create, parameters
      end.not_to change { Chat::Session.count }
    end

    it 'does not create a new session' do
      post :create, parameters
      expect(created_message.text).to eq(text)
    end
  end
end
