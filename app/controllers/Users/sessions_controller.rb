module Users
  class SessionsController < Devise::SessionsController
    include Devise::Controllers::Rememberable
    # GET /user/sign_in
    def new
      if current_user.present?
        flash[:notice] = 'You are already signed in.'
        redirect_to after_sign_in_path_for(current_user)
      end

      @hide_navbar = true
    end
  end
end
