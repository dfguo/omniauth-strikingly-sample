require File.expand_path('lib/omniauth/strategies/strikingly', Rails.root)

puts "Rails.application.config.middleware.use OmniAuth::Builder"
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :strikingly, OAUTH_ID, OAUTH_SECRET,
    :path_prefix => "/oauth"
end