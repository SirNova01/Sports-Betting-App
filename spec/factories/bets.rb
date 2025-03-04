FactoryBot.define do
  factory :bet do
    association :user
    association :game
    amount { 100.0 }
    odds { 1.5 }
    potential_payout { 150.0 }
    bet_type { "home" }
    status { "open" }
  end
end