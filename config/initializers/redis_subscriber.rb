require 'redis'
require 'json'

Thread.new do
  Rails.logger.info "Starting Redis subscriber for 'game_updates' channel."

  begin
    # Connect to Redis (you may already have a global $redis or a config)
    subscriber = Redis.new(
      host: ENV.fetch("REDIS_HOST", "localhost"),
      port: ENV.fetch("REDIS_PORT", 6379)
    )

    # Subscribe to the 'game_updates' channel
    subscriber.subscribe('game_updates') do |on|
      on.message do |channel, message|
        Rails.logger.info "Received message on #{channel}: #{message}"

        # Parse JSON payload from Node.js
        parsed_data = JSON.parse(message) rescue {}

        # Hand off work to Sidekiq (recommended)
        HandleGameUpdateWorker.perform_async(parsed_data)
       Rails.logger.info "handed_off_to_sidekiq"
      end
    end 
  rescue => e
    Rails.logger.error "Redis subscriber error: #{e.message}"
    retry
  end
end


