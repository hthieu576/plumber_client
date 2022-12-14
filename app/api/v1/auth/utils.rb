# frozen_string_literal: true

module V1
  module Auth
    module Utils
      class << self

        def cache
          # Simply use rack-attack cache wrapper
          @cache ||= Rack::Attack::Cache.new
        end

        def urlsafe_string_24
          SecureRandom.urlsafe_base64(18).tr('_-', 'xx')
        end

        # 30 is picked so generated string length is 40
        def urlsafe_string_40
          SecureRandom.urlsafe_base64(30).tr('_-', 'xx')
        end

        alias :generate_access_key :urlsafe_string_40
        alias :generate_secret_key :urlsafe_string_40

        def hmac_signature(secret_key, payload)
          OpenSSL::HMAC.hexdigest 'SHA256', secret_key, payload
        end

      end
    end
  end
end