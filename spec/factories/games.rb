FactoryBot.define do
  factory :game do
    home_team { "Team A" }
    away_team { "Team B" }
    score { "0-0" }
    status { "scheduled" }
    minute { 0 }
    current_odds { { "home" => 1.5, "away" => 2.5, "draw" => 3.0 } }
    external_id { SecureRandom.hex(10) }
  end
end
