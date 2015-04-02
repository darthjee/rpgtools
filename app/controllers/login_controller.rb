class LoginController < ApplicationController
  def index
    render :index, locals: { user: User.new, redirect_path: redirect_path }
  end

  def create
    login(User.find_or_create_by(login_params))
    redirect_to redirect_path
  end

  private

  def login_params
    params.require(:user).permit(:email)
  end

  def redirect_path
    params[:redirect_to] || '/'
  end
end
