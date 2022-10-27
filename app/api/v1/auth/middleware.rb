# frozen_string_literal: true

module V1
  module Auth
    class Middleware < ::Grape::Middleware::Base

      # def request
      #   @request ||= ::Grape::Request.new(env)
      # end

      # def before
      #   headers = Hashie::Mash.new(request.headers)
      #   auth = V1::Auth::Authenticator.new(request, headers)
      #   auth.authenticate!
      # end
    end
  end
end