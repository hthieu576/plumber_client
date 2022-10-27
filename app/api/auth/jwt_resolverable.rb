# frozen_string_literal: true

module Auth
  module JwtResolverable
    def bearer_token
      pattern = /^Bearer /
      auth    = headers[:Authorization]
      auth.gsub(pattern, '') if auth && auth.match(pattern)
    end

    def jwt_payload
      @jwt_payload ||= begin
        payload, _ = JwtEx.decode(bearer_token, secret_key)
        payload.deep_symbolize_keys!
      rescue JWT::VerificationError, JWT::IncorrectAlgorithm
        raise ::V1::Exceptions::JwtVerification, bearer_token
      end
    end

    def access_key
      @access_key ||= begin
        JwtEx.decode(bearer_token, nil, false).first&.send(:[], 'access_key')
      rescue JWT::DecodeError, TypeError
        raise ::V1::Exceptions::JwtDecode.new("bearer_token: #{bearer_token}")
      end
    end
  end
end