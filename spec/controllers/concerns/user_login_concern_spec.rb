require 'spec_helper'

describe UserLoginConcern do
  controller do
    include UserLoginConcern

    before_action :require_logged

    def index
      render nothing: true
    end
  end

  let(:user) { users(:user1) }

  before do
    cookies.delete(:credentials)
  end

  describe 'require_logged' do
    context 'when user is not logged' do
      let(:redirect) { login_index_path(redirect_to: '/anonymous') }

      it 'redirects to redirect_login_path' do
        get :index
        expect(response).to redirect_to(redirect)
      end
    end

    context 'when user is logged' do
      before do
        controller.sign_in(user)
      end

      it 'does not redirect to redirect_login_path' do
        get :index
        expect(response).not_to be_a_redirect
      end
    end
  end

  describe 'login' do

    context 'when user is not logged' do
      it 'store the user email encrypted' do
        controller.sign_in(user)
        expect(cookies.signed[:credentials]).to eq(user.email)
      end
    end
  end

  describe 'logged_user' do
    context 'user is not logged' do
      it { expect(controller.logged_user).to be_nil }
    end

    context 'user is logged' do
      before { controller.sign_in(user) }
      it { expect(controller.logged_user).to eq(user) }
    end
  end
end
