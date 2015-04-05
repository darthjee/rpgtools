require 'spec_helper'

describe UserLoginConcern do
  controller do
    include UserLoginConcern

    before_action :require_logged

    def index
      render nothing: true
    end
  end

  it_behaves_like 'a controller that controls user session' do
    let(:parameters) { {} }
    let(:redirect) { new_login_path(redirect_to: '/anonymous') }
  end
end
