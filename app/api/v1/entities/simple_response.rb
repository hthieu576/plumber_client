# frozen_string_literal: true

module V1
  module Entities
    class SimpleResponse < Base
      expose :success, documentation: { type: Grape::API::Boolean, values: [true, false] }
      expose :message, documentation: { type: String, default: nil }
      expose :origin, documentation: { type: String }, if: lambda { |object, opts| object[:origin] }

    # @formatter:off
    def message
      @object[:message] || @object.try(:message) || begin
        (@object[:success] || @object.try(:success)) ? 'success' : 'failed'
      end
    end
    # @formatter:on

    end
  end
end
