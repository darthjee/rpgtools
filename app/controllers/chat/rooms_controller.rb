class Chat::RoomsController < ApplicationController
  def show
    render :show, { room: room }
  end

  private

  def room
    Chat::Room.find_or_create_by key: params.require(:id)
  end
end
