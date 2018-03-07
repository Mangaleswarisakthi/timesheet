class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
 has_many :identities
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

 # def self.create_with_omniauth(info)
  #  create(name: info['name'])
  #end
 def self.from_omniauth(auth)
   if self.where(email: auth.info.email).exists?
	  return_user = self.where(email: auth.info.email).first
    return_user.provider = auth.provider
    return_user.uid = auth.uid
	else
	return_user = self.create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
user.email = auth.info.email
user.password = "chithra"
      user.save!
    end
end
return_user
  end

end
