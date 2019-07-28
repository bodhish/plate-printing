module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def failure
      redirect_to oauth_error_path
    end

    def auth_callback
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user, event: :authentication
    end

    alias google_oauth2 auth_callback
  end
end