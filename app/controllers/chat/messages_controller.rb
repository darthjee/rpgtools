class Chat::MessagesController < ApplicationController
  def create
    Chat::Message.create(message_params)
    redirect_to room_path(room.key)
  end

  private

  def message_params
    params.require(:chat_message).permit(
      :text, :action
    ).merge(room: room, session: chat_session)
  end

  def chat_session
    Chat::Session.find_by(user: user_logged, room: room)
  end

  def room
    Chat::Room.find_or_create_by key: params.require(:room_id)
  end
end
