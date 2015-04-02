class Chat::Room < ActiveRecord::Base
  has_many :sessions
end