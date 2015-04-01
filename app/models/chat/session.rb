class Chat::Session < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
end