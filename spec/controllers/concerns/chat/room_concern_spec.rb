require 'spec_helper'

describe Chat::RoomConcern do
  let(:room) { chat_rooms(:default) }
  let(:parameters) { { room_id: room.key } }

  describe '#require_logged' do
    controller do
      include Chat::RoomConcern

      before_action :require_logged

      def index
        render nothing: true
      end
    end

    it_behaves_like 'a controller that requires logged user' do
      let(:redirect) do
        new_chat_room_login_path(room_id: room.key, redirect_to: '/anonymous')
      end
    end
  end

  describe '#chat_session' do
    controller do
      include Chat::RoomConcern

      def index
        render json: chat_session
      end
    end

    before { controller.sign_in(user) }

    context 'there is a session for the user in the room' do
      let(:user) { users(:with_chat_session) }
      let(:chat_session) { chat_sessions(:default_with_session) }

      it 'returns the current session' do
        get :index, parameters
        expect(response.body).to eq(chat_session.to_json)
      end
    end

    context 'there is no session for the user in the room' do
      let(:user) { users(:user1) }

      it 'returns the current session' do
        get :index, parameters
        expect(response.body).to eq('null')
      end
    end
  end
end
