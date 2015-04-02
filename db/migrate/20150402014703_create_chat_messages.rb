class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.string :text, null: false
      t.string :action, null: false, default: :say
      t.integer :room_id, null: false
      t.integer :session_id, null: false
      t.integer :target_id, null: true
      t.string :action_variables, null: true
      t.timestamps
    end
  end
end
