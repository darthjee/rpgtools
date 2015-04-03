require 'spec_helper'

describe LoginController do
  describe 'create' do
    let(:email) { 'new_user@server.com' }
    let(:redirect_path) { '/new_path' }
    let(:parameters) { { user: { email: email }, redirect_to: redirect_path } }

    context 'when sending redirect path' do
      it 'creates the user' do
        expect { get :create, parameters }.to change { User.count }.by(1)
        expect(User.last.email).to eq(email)
      end

      it 'redirects to given redirect path' do
        get :create, parameters
        expect(response).to redirect_to(redirect_path)
      end
    end

    context 'when sending redirect path' do
      before { parameters.delete(:redirect_to) }

      it 'creates the user' do
        expect { get :create, parameters }.to change { User.count }.by(1)
      end

      it 'redirects to root path' do
        get :create, parameters
        expect(response).to redirect_to('/')
      end
    end
  end
end
