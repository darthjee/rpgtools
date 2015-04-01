class CreateChatSessions < ActiveRecord::Migration
  def change
    create_table :chat_sessions do |t|
      t.string :nick
      t.integer :room_id
      t.integer :user_id
    end
  end
end
