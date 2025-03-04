# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:bets).dependent(:destroy) }
  end

  describe 'validations' do
    subject { FactoryBot.create(:user) }  # needed for uniqueness tests

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    
    it { should allow_value("user@example.com").for(:email) }
    it { should_not allow_value("invalid_email").for(:email) }
  end

  describe 'has_secure_password' do
    it 'authenticates with the correct password' do
      user = FactoryBot.create(:user, password: 'secret', password_confirmation: 'secret')
      expect(user.authenticate('secret')).to eq(user)
    end

    it 'does not authenticate with an incorrect password' do
      user = FactoryBot.create(:user, password: 'secret', password_confirmation: 'secret')
      expect(user.authenticate('wrong')).to be_falsey
    end
  end

  describe '.leaderboard_top_winnings' do
    it 'limits the results to the given number by generating SQL with LIMIT' do
      sql = User.leaderboard_top_winnings(5).to_sql
      expect(sql).to include("LIMIT 5")
    end
  end

  
end
