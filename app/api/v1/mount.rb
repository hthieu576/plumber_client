# frozen_string_literal: true

module V1
  class Mount < Grape::API
    PREFIX = '/api'

    version 'v1', using: :path

    cascade false

    format :json
    default_format :json
    default_error_formatter :json

    # helpers ::Helpers::EssentialHelper

    before do
      header 'Access-Control-Allow-Origin', '*'
    end

    mount V1::Jobs
  end
end