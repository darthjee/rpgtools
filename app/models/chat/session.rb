class Chat::Session < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  validates_presence_of :user, :room, :nick

  def self.create_or_update(attributes)
    nick = attributes.delete(:nick)

    find_or_create_by(attributes).tap do |s|
      s.update(nick: nick)
    end
  end
end
