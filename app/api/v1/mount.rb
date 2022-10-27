# frozen_string_literal: true

module V1
  class Mount < Grape::API
    PREFIX = '/api'

    version 'v1', using: :path

    cascade false

    format :json
    default_format :json
    default_error_formatter :json

    # insert_after Grape::Middleware::Formatter, V1::Auth::Middleware

    mount V1::Jobs

    scope :docs do
      base_path = PREFIX
      add_swagger_documentation(
        base_path:   base_path,
        mount_path:  'docs',
        api_version: 'v1',
        doc_version: 'v1',
        info:        { title: 'Plumber Client', description: '' },
        tags:        [
                       { name: 'Jobs', description: 'Operations about jobs' },
                     ]
      )
    end
  end
end