require 'spec_helper'

describe Chat::RoomsController do
  describe 'show' do
    let(:parameters) { { id: key } }

    context 'when room exists' do
      let(:room) { chat_rooms(:default) }
      let(:key) { room.key }

      it 'does not create a new room' do
        expect do
          get :show, parameters
        end.not_to change { Chat::Room.count }
      end
    end

    context 'when room does not exist' do
      let(:key) { 'new_room' }

      it 'does not create a new room' do
        expect do
          get :show, parameters
        end.to change { Chat::Room.count }.by(1)
      end
    end
  end
end
