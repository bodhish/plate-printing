class AdminController < ApplicationController
  before_action :authenticate_admin_user!
  layout 'tailwind'

  def admin_dashboard;
  end
end
