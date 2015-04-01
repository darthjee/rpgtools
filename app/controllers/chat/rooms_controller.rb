class Chat::RoomsController < ApplicationController
  def show
    render :show, { room: created_room }
  end

  private

  def created_room
    room
  rescue ActiveRecord::RecordNotFound
    Chat::Room.create key: params.require(:id)
  end

  def room
    Chat::Room.find_by! key: params.require(:id)
  end
end
