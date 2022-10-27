# frozen_string_literal: true

module Auth
  class Authenticator
    attr_reader :jwt_authenticator, :headers

    delegate :api_token, :token, :access_key, to: :jwt_authenticator

    def initialize(request, headers)
      @headers           = headers || Hashie::Mash.new
      @jwt_authenticator = ::Auth::JwtAuthenticator.new(request, headers)
    end

    def authenticate!
      jwt_authenticator.authenticate!&.tap do |o|
        o.admin_user? or raise ::V1::Exceptions::OutOfScope
      end
    end

  end
end