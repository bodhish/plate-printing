class AdminController < ApplicationController
  before_action :authenticate_admin_user!

  def admin_dashboard;
  end
end
