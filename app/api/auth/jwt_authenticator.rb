# frozen_string_literal: true

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
      raise ::V1::Exceptions::NoAuthorizationToken unless bearer_token
      raise ::V1::Exceptions::NoAccessKey, "bearer_token:#{bearer_token}" unless access_key
      raise ::V1::Exceptions::InvalidAccessKey, "access_key:#{access_key}" unless api_token
      raise ::V1::Exceptions::JwtVerification, "bearer_token:#{bearer_token}" unless jwt_payload
      raise ::V1::Exceptions::ExpiredAccessKey, "access_key#{access_key}" if api_token.expired?
    end
  end
end