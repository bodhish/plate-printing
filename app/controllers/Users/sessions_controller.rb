module Users
  class SessionsController < Devise::SessionsController
    include Devise::Controllers::Rememberable
    # GET /user/sign_in
    def new
      if current_user.present?
        flash.now[:notice] = 'You are already signed in.'
        redirect_to after_sign_in_path_for(current_user)
      end

      @hide_navbar = true
    end

    def create
      user = User.find_by(email: params[:user][:email])
      if user && user.valid_password?(params[:user][:password])
        sign_in user
        redirect_to after_sign_in_path_for(user)
      else
        flash.now[:error] = 'Invalid username/password!'
        render :new
      end
    end
  end
end
