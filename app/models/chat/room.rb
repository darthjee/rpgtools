class Chat::Room < ActiveRecord::Base
  has_many :sessions
  has_many :messages
end