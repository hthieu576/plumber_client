# frozen_string_literal: true

module V1
  module Auth
    class JwtAuthenticator
      include JwtResolverable

      attr_reader :request, :headers

      def initialize(request, headers)
        @request = request
        @headers = headers || Hashie::Mash.new
      end

      def authenticate!
        check_token!
        api_token
      end

      def api_token
        @api_token ||= ApiToken.find_by(access_key: access_key)
      end

      alias_method :token, :api_token

      def secret_key
        api_token&.secret_key
      end

      def check_token!
        raise I18n.t('V1.Exceptions.NoAuthorizationToken.body') unless bearer_token
        raise I18n.t('V1.Exceptions.NoAccessKey.body') unless access_key
        raise I18n.t('V1.Exceptions.InvalidAccessKey.body') unless api_token
        raise I18n.t('V1.Exceptions.JwtVerification.body') unless jwt_payload
        raise I18n.t('V1.Exceptions.ExpiredAccessKey.body') if api_token.expired?
      end
    end
  end
end