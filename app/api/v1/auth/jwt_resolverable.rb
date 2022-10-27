# frozen_string_literal: true

module V1
  module Auth
    module JwtResolverable
      def bearer_token
        pattern = /^Bearer /
        auth    = headers[:Authorization]
        auth.gsub(pattern, '') if auth && auth.match(pattern)
      end

      def jwt_payload
        @jwt_payload ||= begin
          payload, _ = jwt_decode(bearer_token, secret_key)
          payload.deep_symbolize_keys!
        rescue JWT::VerificationError, JWT::IncorrectAlgorithm
          raise I18n.t('V1.Exceptions.NoAuthorizationToken.body')
        end
      end

      def access_key
        @access_key ||= begin
          jwt_decode(bearer_token, nil, false).first&.send(:[], 'access_key')
        rescue JWT::DecodeError, TypeError
          raise I18n.t('V1.Exceptions.InvalidAccessKey.body')
        end
      end

      def jwt_decode(jwt, key = nil, verify = true)
        payload, header = JWT.decode(jwt, key, false)
        raise JWT::IncorrectAlgorithm if verify && header['alg'] == 'none'
        payload         = JWT.decode(jwt, key, true, {algorithm: header['alg']})[0] || {} if key && (header['alg'] != 'none' || verify)
        [payload, header]
      end
    end
  end
end