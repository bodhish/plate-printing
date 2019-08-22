module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def auth_callback
      @user = User.from_omniauth(request.env["omniauth.auth"])
      name = request.env["omniauth.auth"]['info']['name']
      avatar = request.env["omniauth.auth"]['info']['image']
      if @user
        @user.update!(name: name, avatar: avatar) if @user
        sign_in_and_redirect @user, event: :authentication
      else
        flash[:error] = 'Login failed! Please try again.'
        redirect_to new_user_session_path
      end
    end

    alias google_oauth2 auth_callback
  end
end