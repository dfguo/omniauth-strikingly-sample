class MainController < ApplicationController
  def index
    # /r/v1/users/me/summary
    # /api/v1/me
    # /api/v1/app_instances/14/settings
    puts session['omniauth.auth']
    render :text => access_token.get('/api/v1/app_instances/14/settings').body
  end
  
  
  private
  def oauth_client
    @oauth_client ||= OAuth2::Client.new(OAUTH_ID, OAUTH_SECRET, site: "http://www.strikingly.dev:3000/")
  end

  def access_token
    token = session['omniauth.auth']['credentials']['token']
    if token
      @access_token ||= OAuth2::AccessToken.new(oauth_client, token)
    end
  end
end