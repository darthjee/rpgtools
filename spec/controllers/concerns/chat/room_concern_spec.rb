require 'spec_helper'

describe Chat::RoomConcern do
  controller do
    include Chat::RoomConcern

    before_action :require_logged

    def index
      render nothing: true
    end
  end

  let(:room) { chat_rooms(:default) }

  it_behaves_like 'a controller that requires logged user' do
    let(:parameters) { { room_id: room.key } }
    let(:redirect) do
      new_chat_room_login_path(room_id: room.key, redirect_to: '/anonymous')
    end
  end
end
