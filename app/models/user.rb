class User < ActiveRecord::Base

  def self.create_from_google(auth_hash)
    user       = User.new
    user.uid   = auth_hash.uid
    user.provider = 'google'
    user.name  = auth_hash.info.name
    user.email = auth_hash.info.email
    user.image = auth_hash.info.image
    user.save

    return user
  end
end
