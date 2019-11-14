class User < ApplicationRecord
  devise :database_authenticatable, :rememberable,
    :validatable, :omniauthable, omniauth_providers: %i[google_oauth2]

  validates_presence_of :name


  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    user
  end

  def avatar
    super || initials_avatar
  end

  def initials_avatar(background_shape: nil)
    logo = Scarf::InitialAvatar.new(name, background_shape: background_shape)
    "data:image/svg+xml;base64,#{Base64.encode64(logo.svg)}"
  end
end
