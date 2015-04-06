class Chat::LoginController < LoginController
  def new
    render :new, locals: {
      chat_session: Chat::Session.new,
      redirect_path: redirect_path
    }
  end

  def create
    sign_in(created_session.user)
    redirect_to redirect_path
  end

  private

  def created_session
    (chat_session || Chat::Session.create(session_creation_params)).tap do |s|
      s.update(session_params)
    end
  end

  def chat_session
    Chat::Session.find_by(user: user_created, room: room)
  end

  def session_creation_params
    session_params.merge(
      user: user_created,
      room: room
    )
  end

  def session_params
    params.require(:chat_session).permit(:nick)
  end

  def user_created
    email = params.require(:chat_session).require(:user).permit(:email)
    User.find_or_create_by(email)
  end

  def room
    Chat::Room.find_or_create_by key: params.require(:room_id)
  end
end
