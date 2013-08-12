class User < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :clock
  belongs_to :status

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
        pp auth['credentials'] unless Rails.env.production?
        user.access_token = auth['credentials']['token'] || ""
        user.refresh_token = auth['credentials']['refresh_token'] || ""
        user.expires_at = auth['credentials']['expires_at'] || nil
        pp user unless Rails.env.production?
      end
    end
  end

  def token
    if Time.now > expires_at
      # The token has expired
      nil
    else
      access_token
    end
  end
end
