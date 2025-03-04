# spec/models/bet_spec.rb
require 'rails_helper'

RSpec.describe Bet, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:game) }
  end

  describe 'validations' do
    subject { FactoryBot.create(:bet) }  # create one bet instance for uniqueness tests

    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }

    it { should validate_presence_of(:odds) }
    it { should validate_numericality_of(:odds).is_greater_than(0) }

    it { should validate_presence_of(:potential_payout) }
    it { should validate_numericality_of(:potential_payout).is_greater_than(0) }

    it do
      should validate_uniqueness_of(:game_id)
        .scoped_to(:user_id)
        .with_message('You have already placed a bet on this game')
    end

  end

  describe 'bet_type enum' do
    it 'allows valid bet_type values' do
      bet = FactoryBot.build(:bet, bet_type: 'home')
      expect(bet.bet_type).to eq('home')
  
      bet.bet_type = 'away'
      expect(bet.bet_type).to eq('away')
  
      bet.bet_type = 'draw'
      expect(bet.bet_type).to eq('draw')
    end
  
    it 'rejects invalid bet_type values' do
      bet = FactoryBot.build(:bet)
      expect { bet.bet_type = 'invalid' }.to raise_error(ArgumentError)
    end
  end
  

  describe 'callbacks' do
    include ActiveJob::TestHelper

    it 'enqueues UpdateLeaderboardJob after saving a bet' do
      clear_enqueued_jobs
      bet = FactoryBot.build(:bet)
      bet.save!
      expect(enqueued_jobs.map { |job| job[:job] }).to include(UpdateLeaderboardJob)
    end
  end
end
