# spec/models/game_spec.rb
require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associations' do
    it { should have_many(:bets).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:home_team) }
    it { should validate_presence_of(:away_team) }
  end

  describe 'callbacks' do
    include ActiveJob::TestHelper

    let!(:game) { FactoryBot.create(:game, status: 'scheduled') }

    context 'when status changes to finished' do
      it 'enqueues UpdateBetStatusJob' do
        clear_enqueued_jobs
        game.update!(status: 'finished')
        expect(enqueued_jobs.map { |job| job[:job] }).to include(UpdateBetStatusJob)
      end
    end

    context 'when status changes but is not finished' do
      it 'does not enqueue UpdateBetStatusJob' do
        clear_enqueued_jobs
        game.update!(status: 'in_progress')
        expect(enqueued_jobs.map { |job| job[:job] }).not_to include(UpdateBetStatusJob)
      end
    end

    context 'when other attributes update but status does not change' do
      it 'does not enqueue UpdateBetStatusJob' do
        # First, set the status to finished so that a later update does not trigger a status change.
        game.update!(status: 'finished')
        clear_enqueued_jobs
        game.update!(home_team: 'Updated Home Team')
        expect(enqueued_jobs.map { |job| job[:job] }).not_to include(UpdateBetStatusJob)
      end
    end
  end
end
