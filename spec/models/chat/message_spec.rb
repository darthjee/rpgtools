require 'spec_helper'

describe Chat::Message do
  describe :validations do
    let(:message) { chat_messages(:first) }

    context 'when room has not been defined' do
      before { message.room = nil }

      it { expect(message).to be_invalid }
    end
  end
end
