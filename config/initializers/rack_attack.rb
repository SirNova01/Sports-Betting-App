class Rack::Attack
  throttle('req/ip', limit: 60, period: 1.minute) do |req|
    req.ip 
  end
end

ActiveSupport::Notifications.subscribe('rack.attack') do |_name, _start, _finish, _request_id, payload|
  req = payload[:request]
  if req.env['rack.attack.match_type'] == :throttle
    Rails.logger.info "Throttled IP: #{req.ip} #{req.request_method} #{req.fullpath}"
  end
end
