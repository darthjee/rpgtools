require 'spec_helper'

describe LoginController do
  describe 'create' do
    let(:email) { 'new_user@server.com' }
    let(:redirect_path) { '/new_path' }
    let(:parameters) { { user: { email: email }, redirect_to: redirect_path } }

    it_behaves_like 'a controller that handles user login'
  end
end
