class Game < ApplicationRecord
  include Gridled

  include ActionView::RecordIdentifier

  belongs_to :puzzle
  broadcasts
  after_update_commit -> { broadcast_replace_later target: dom_id(self, :time), partial: 'games/time' }
end
