# frozen_string_literal: true

module V1
  module Entities
    class Job < Base
      expose :id
      expose :description
      expose :time_period
      expose :status
      expose :estimate_distance
      expose :estimate_time_by_vehicles
      expose :client, using: V1::Entities::Client
    end
  end
end
