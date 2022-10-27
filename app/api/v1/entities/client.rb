# frozen_string_literal: true

module V1
  module Entities
    class Client < Base
      expose :id
      expose :name
      expose :address
      expose :age
    end
  end
end
