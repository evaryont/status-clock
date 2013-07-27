class User < ActiveRecord::Base
  validates_presence_of :name

  # Create a new User instance by passing in the hash results from
  # env['omniauth.auth']
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
      end
      if auth['credentials']
        user.token_code = auth['credentials']['token'] || ""
        user.expires_at = auth['credentials']['expires_at'] || nil
      end
    end
  end

  def token
    if Time.now > expires_at
      # The token has expired
      nil
    else
      token_code
    end
  end

end
