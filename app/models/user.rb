class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
 has_many :identity
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :github]
def self.from_omniauth(auth)
    user = Identity.where(:provider => auth.provider, :uid => auth.uid).first
        unless user.nil?
            user.user
        else
		
            registered_user = User.where(:email => auth.info.email).first
            unless registered_user.nil?
                        Identity.create!(
                              provider: auth.provider,
                              uid: auth.uid,
                              user_id: registered_user.id
                              )
                registered_user
            else
		puts auth.info
                user = User.create!(
                    name: auth.info.name,
                            email: auth.info.email,
                            password: Devise.friendly_token[0,20],
                            )
                user_provider = Identity.create!(
                    provider:auth.provider,
                            uid:auth.uid,
                              user_id: user.id
                    )
                user
            end
        end
end
end
