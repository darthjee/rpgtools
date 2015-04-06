module Chat::RoomConcern
  extend ActiveSupport::Concern

  private

  def room
    @room ||= Chat::Room.find_or_create_by key: room_key
  end

  def room_key
    @room_key ||= (params[:room_id] || params.require(:id))
  end
end
