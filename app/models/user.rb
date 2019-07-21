class User < ApplicationRecord
  devise :rememberable, :omniauthable, omniauth_providers: [:google_oauth2]
end
