# frozen_string_literal: true

module V1
  module Entities
    class Base < Grape::Entity
      format_with(:upcase) { |i| i.upcase if i }
      format_with(:iso8601) { |t| t.to_time.iso8601 if t }
      format_with(:unix_epoch_second) { |i| i.to_i if i }
      format_with(:decimal) { |d| d.to_d }
      format_with(:integer) { |i| i.to_i }
    end
  end
end
