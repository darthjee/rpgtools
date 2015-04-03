module Chat::UserLoginConcern
  extend UserLoginConcern

  private

  def redirect_login_path
    chat_room_login_index_path(room.key, redirect_to: request.path)
  end
end