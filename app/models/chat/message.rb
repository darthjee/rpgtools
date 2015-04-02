class Chat::Message < ActiveRecord::Base
  belongs_to :room
  belongs_to :session
  belongs_to :target, class: Chat::Session
end