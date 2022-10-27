# frozen_string_literal: true

module V1
  module Entities
    class Job < Base
      expose :id
      expose :description
    end
  end
end
