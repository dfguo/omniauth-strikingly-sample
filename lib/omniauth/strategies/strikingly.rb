require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Strikingly < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => "http://www.strikingly.dev:3000",
        :authorize_url => "/oauth/authorize"
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me').parsed['data']
      end

      ##
      # You can pass +display+, +with_offical_account+ or +state+ params to the auth request, if
      # you need to set them dynamically. You can also set these options
      # in the OmniAuth config :authorize_params option.
      #
      def authorize_params
        super.tap do |params|
          %w[state].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
              # to support omniauth-oauth2's auto csrf protection
              session['omniauth.state'] = parse_state(params[:state]) if v == 'state'
            end
          end
        end
      end
      
      private 
        # app_instance_id:14,app:social_feed
        def parse_state(state)
          state.split(',').reduce({}) do |h, s|
            s_arr = s.split(':')
            h[s_arr[0]] = s_arr[1]
          end
        end  
    end
  end
end

OmniAuth.config.add_camelization "strikingly", "Strikingly"