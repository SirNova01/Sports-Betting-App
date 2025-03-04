class Game < ApplicationRecord
  after_update :process_bets_if_finished

  has_many :bets, dependent: :destroy

  validates :home_team, :away_team, presence: true

  private

  def process_bets_if_finished
    if saved_change_to_status? && status == 'finished'

      UpdateBetStatusJob.perform_later(id)
    end
  end
end
