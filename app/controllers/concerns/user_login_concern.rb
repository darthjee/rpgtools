module UserLoginConcern
  extend ActiveSupport::Concern

  private

  def require_logged
    redirect_to login_index_path(redirect_to: request.path) unless user_logged?
  end

  def user_logged?
    logged_user.present?
  end

  def logged_user
    return nil unless credential_cookie.present?
    User.find_by email: cookies.signed[:credentials]
  end

  def credential_cookie
    cookies.signed[:credentials]
  end

  def login(user)
    cookies.signed[:credentials] = user.email
  end
end