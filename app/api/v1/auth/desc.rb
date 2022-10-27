# frozen_string_literal: true

module V1
  module Auth
    class Desc
      def self.headers
        {
          Authorization: {
            default:     'Bearer <token>',
            description: 'access key 를 갖는 bearer token',
            required:    true
          }
        }
      end
    end
  end
end