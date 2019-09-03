class ApplicationController < ActionController::Base
  def authenticate_admin_user!
    unless current_user && current_user.is_admin
      admin_access_denied
    end
  end

  def admin_access_denied
    flash[:error] = 'You are not an admin!'
    redirect_to root_path
  end
end
