# frozen_string_literal: true

module V1
  module Exceptions

    class Unauthorized; end

    class ExpiredAccessKey < Unauthorized
    end

    class InvalidAccessKey < Unauthorized
    end

    class NoAuthorization < Unauthorized
    end

    class JwtDecode < Unauthorized
    end

    class NoAuthorizationToken < Unauthorized
    end

    class NoAccessKey < Unauthorized
    end

    class JwtVerification < Unauthorized
    end
  end
end