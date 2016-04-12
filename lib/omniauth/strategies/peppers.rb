require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Peppers < OmniAuth::Strategies::OAuth2

      PROVIDER_URL = 'http://peppers.caiena.net'

      CLIENT_OPTIONS = {
        site: "#{PROVIDER_URL}/api/v1",
        authorize_url: "#{PROVIDER_URL}/oauth/authorize",
        token_url: "#{PROVIDER_URL}/oauth/access_token"
      }

      option :client_options, CLIENT_OPTIONS

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          name: raw_info['name'],
          email: raw_info['email']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('credentials/me').parsed
      end
    end
  end
end
