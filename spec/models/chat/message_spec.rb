require 'spec_helper'

describe Chat::Message do
  describe :validations do
    let(:object) { chat_messages(:first) }

    it_behaves_like 'object that has mandatory attributes', :room, :session, :text
  end
end
