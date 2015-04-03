class Chat::LoginController < LoginController

  def index
    render :index, locals: { chat_session: Chat::Session.new, redirect_path: redirect_path }
  end

  def create
    Chat::Session.create session_creation_params
    login(user)
    redirect_to redirect_path
  end

  private

  def session_creation_params
    session_params.merge({
      user: user_created,
      room: room
    })
  end

  def session_params
    params.require(:chat_session).permit(:user, :nick)
  end

  def user_created
    User.find_or_create_by(session_params[:user])
  end

  def room
    Chat::Room.find_or_create_by key: params.require(:room_id)
  end
end
