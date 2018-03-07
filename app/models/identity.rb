class Identity < ApplicationRecord
  belongs_to :user
 def self.create_with_omniauth(auth)
    create(uid: auth['uid'], provider: auth['provider'])
  end
end
