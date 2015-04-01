class CreateRooms < ActiveRecord::Migration
  def change
    create_table :chat_rooms do |t|
      t.string :key
    end
  end
end
