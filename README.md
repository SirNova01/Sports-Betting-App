
# Sports Betting App

Welcome to the **Sports Betting App**! This is a Ruby on Rails application that allows users to place and track bets on sports events.

## Prerequisites
Ensure you have the following installed:
- **Ruby** (Check version with `ruby -v`)
- **Rails** (Check version with `rails -v`)
- **Bundler** (`gem install bundler` if not installed)
- **PostgreSQL** (or your preferred database)
- **Redis** (for Sidekiq background jobs)
- **Sidekiq** (for background processing)

## Getting Started
### 1. Clone the Repository
```sh
git clone https://github.com/SirNova01/Sports-Betting-App.git
cd Sports-Betting-App
```

### 2. Install Dependencies
```sh
bundle install
```

### 3. Setup Database
Make sure PostgreSQL is running, then create and migrate the database:
```sh
rails db:create db:migrate
```

### 4. Start the Rails Server
Run the application:
```sh
rails server
```
It should now be accessible at `http://localhost:3000/`.

## Running Redis & Sidekiq
### 1. Start Redis (Required for Sidekiq)
```sh
redis-server
```

### 2. Start Sidekiq
In a separate terminal, run:
```sh
bundle exec sidekiq
```
Sidekiq will start processing background jobs.

## Additional Notes
- If using **Docker**, you can run Redis using:
  ```sh
  docker run -d -p 6379:6379 redis
  ```
- If you encounter any issues, check the logs:
  ```sh
  tail -f log/development.log
  ```


