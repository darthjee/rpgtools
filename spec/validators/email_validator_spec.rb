require 'spec_helper'

describe EmailValidator do
  class EmailValidator::Dummy
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :email_attr
    validates :email_attr, email: true
  end

  let(:subject) { EmailValidator::Dummy.new email_attr: email }

  %w(
    user@email.com user.name@email.com user.name@email.com
    user_name@email.com user_name@email.com.br user2@email.com
  ).each do |valid_email|
    context "object with #{valid_email} for email" do
      let(:email) { valid_email }

      it { expect(subject).to be_valid }
    end
  end

  %w(
    user @server.com .name@email.com 2user@email.com
  ).each do |invalid_email|
    context "object with #{invalid_email} for email" do
      let(:email) { invalid_email }

      it { expect(subject).to be_invalid }
      it { expect(subject).to have(1).error_on(:email_attr) }
    end
  end
end
