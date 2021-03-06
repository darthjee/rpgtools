class Chat::MessagesController < ApplicationController
  include Chat::RoomConcern

  def create
    Chat::Message.create(message_params)
    redirect_to chat_room_path(room.key)
  end

  private

  def message_params
    params.require(:chat_message).permit(
      :text, :action
    ).merge(room: room, session: chat_session)
  end
end
