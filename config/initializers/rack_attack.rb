Rack::Attack.throttle('req/ip', limit: 1000, period: 1.day) do |request|
  request.ip
end

ActiveSupport::Notifications.subscribe(/rack_attack/) do |name, start, finish, request_id, payload|
  req = payload[:request]
  if %i[throttle].include? req.env['rack.attack.match_type']
    Rack::Attack.throttle('req/ip', limit: 1, period: 10) do |request|
      request.ip
    end
  end
end

Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new