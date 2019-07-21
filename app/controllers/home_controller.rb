class HomeController < ApplicationController
  before_action :authenticate_user!, except: :login

  def dashboard; end

  def login; end
end
