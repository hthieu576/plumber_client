# frozen_string_literal: true

module V1
  class Jobs < Grape::API

    helpers do
      def request
        @request ||= ::Grape::Request.new(env)
      end

      def authenticate!
        headers = Hashie::Mash.new(request.headers)
        auth = V1::Auth::Authenticator.new(request, headers)
        auth.authenticate!
      end
    end

    desc 'jobs' do
      headers Auth::Desc.headers
      success V1::Entities::Job
    end
    get '/jobs' do
      authenticate!
      jobs =  Job.all
      present jobs, with: V1::Entities::Job
    end
  end
end