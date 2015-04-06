class Chat::LoginController < LoginController
  include Chat::RoomConcern

  def new
    render :new, locals: {
      chat_session: Chat::Session.new,
      redirect_path: redirect_path
    }
  end

  def create
    sign_in(chat_session.user)
    redirect_to redirect_path
  end

  private

  def chat_session
    Chat::Session.create_or_update(session_creation_params)
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
end
