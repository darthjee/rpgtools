class Chat::RoomsController < ApplicationController
  include Chat::RoomConcern
  include Chat::UserLoginConcern

  before_action :require_logged

  def show
    render :show, locals: { room: room, message: Chat::Message.new }
  end
end
