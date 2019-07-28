class User < ApplicationRecord
  devise :database_authenticatable, :rememberable,
    :validatable, :omniauthable, omniauth_providers: %i[google_oauth2]


  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    user
  end
end
