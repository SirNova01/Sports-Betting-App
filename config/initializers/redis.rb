require 'redis'

$redis = Redis.new(
  host: ENV.fetch("REDIS_HOST") { 'localhost' },
  port: ENV.fetch("REDIS_PORT") { 6379 }
)

