class LoginController < ApplicationController
  def new
    render :new, locals: { user: User.new, redirect_path: redirect_path }
  end

  def create
    sign_in(user_created)
    redirect_to redirect_path
  end

  private

  def login_params
    params.require(:user).permit(:email)
  end

  def redirect_path
    params[:redirect_to] || '/'
  end

  def user_created
    User.find_or_create_by(login_params)
  end
end
