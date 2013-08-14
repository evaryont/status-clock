Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['OMNIAUTH_PROVIDER_KEY'], ENV['OMNIAUTH_PROVIDER_SECRET'], {
    scope: 'plus.me,userinfo.email,userinfo.profile',
    access_type: 'offline',
    prompt: 'select_account consent'
  }
end
