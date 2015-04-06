class Chat::Session < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  def self.create_or_update(attributes)
    attributes = attributes.deep_symbolize_keys
    nick = attributes.delete(:nick)

    find_or_create_by(attributes).tap do |s|
      s.update(nick: nick)
    end
  end
end
