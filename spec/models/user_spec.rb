require 'spec_helper'

describe User do
  describe 'validations' do
    let(:email) { 'email.new_last+tag@server.com.br' }
    let(:user) { User.new email: email }

    context 'when user is valid' do
      it { expect(user).to be_valid }
    end

    context 'when user has an invalid email' do
      let(:email) { 'email' }
      it { expect(user).to be_invalid }
    end
  end
end
