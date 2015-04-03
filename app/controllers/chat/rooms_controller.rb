class Chat::RoomsController < Chat::BaseController
  before_action :require_logged

  def show
    render :show, locals: { room: room, message: Chat::Message.new }
  end

  private

  def room
    Chat::Room.find_or_create_by key: params.require(:id)
  end
end
