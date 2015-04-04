require 'spec_helper'

describe EmailValidator do
  class EmailValidator::Dummy
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :email_attr
    validates :email_attr, email: true
  end

  let(:subject) { EmailValidator::Dummy.new email_attr: email }

  shared_context 'an object with valid email' do |valid_email|
    context "object with #{valid_email} for email" do
      let(:email) { valid_email }

      it { expect(subject).to be_valid }
    end
  end

  shared_context 'an object with invalid email' do |invalid_email|
    if invalid_email.nil?
      display = 'nil'
    elsif invalid_email.empty?
      display = "''"
    else
      display = invalid_email
    end
    context "object with #{display} for email" do
      let(:email) { invalid_email }

      it { expect(subject).to be_invalid }
      it { expect(subject).to have(1).error_on(:email_attr) }
    end
  end

  %w(
    user@email.com user.name@email.com user.name@email.com
    user_name@email.com user_name@email.com.br user2@email.com
    user+2name@server.com
  ).each { |email| it_behaves_like 'an object with valid email', email }

  %w(
    user @server.com .name@email.com 2user@email.com
    user_2name@email.com user.2name@email.com 2user@email.com
  ).each { |email| it_behaves_like 'an object with invalid email', email }

  it_behaves_like 'an object with invalid email', ''
  it_behaves_like 'an object with invalid email', nil
end
