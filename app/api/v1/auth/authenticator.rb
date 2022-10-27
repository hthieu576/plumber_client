# frozen_string_literal: true

module V1
  module Auth
    class Authenticator
      attr_reader :jwt_authenticator, :headers

      delegate :api_token, :token, :access_key, to: :jwt_authenticator

      def initialize(request, headers)
        @headers           = headers || Hashie::Mash.new
        @jwt_authenticator = ::V1::Auth::JwtAuthenticator.new(request, headers)
      end

      def authenticate!
        jwt_authenticator.authenticate!&.tap do |o|
          o.admin_user.present? or raise I18n.t('V1.Exceptions.NoAuthorizationToken.body')
        end
      end

    end
  end
end