class Chat::RoomsController < ApplicationController
  include Chat::RoomConcern

  before_action :require_logged

  def show
    render :show, locals: { room: room, message: Chat::Message.new }
  end
end
