module Chat::RoomConcern
  extend UserLoginConcern

  private

  def redirect_login_path
    new_chat_room_login_path(room.key, redirect_to: request.path)
  end

  def room
    @room ||= Chat::Room.find_or_create_by key: room_key
  end

  def chat_session
    Chat::Session.find_by(user: logged_user, room: room)
  end

  def room_key
    @room_key ||= (params[:room_id] || params.require(:id))
  end
end
