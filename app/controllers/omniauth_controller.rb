class OmniauthController < ApplicationController
  def callback
    # verify and shit here   
    # puts "session.inspect"
    session['omniauth.auth'] = request.env['omniauth.auth']
    redirect_to '/'
  end
end