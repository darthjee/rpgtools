class Chat::RoomsController < ApplicationController
  def show
    render :show, locals: { room: room, message: Chat::Message.new }
  end

  private

  def room
    Chat::Room.find_or_create_by key: params.require(:id)
  end
end
