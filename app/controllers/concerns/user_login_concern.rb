module UserLoginConcern
  extend ActiveSupport::Concern

  def require_logged
    redirect_to redirect_login_path unless user_logged?
  end

  def user_logged?
    logged_user.present?
  end

  def logged_user
    return nil unless credential_cookie.present?
    User.find_by email: credential_cookie
  end

  def sign_in(user)
    cookies.signed[:credentials] = user.email
  end

  private

  def redirect_login_path
    new_login_path(redirect_to: request.path)
  end

  def credential_cookie
    cookies.signed[:credentials]
  end
end
