module Chat::UserLoginConcern
  extend UserLoginConcern

  private

  def redirect_login_path
    new_chat_room_login_path(room.key, redirect_to: request.path)
  end
end