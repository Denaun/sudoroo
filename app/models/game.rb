class Game < ApplicationRecord
  include Gridled

  belongs_to :puzzle
  broadcasts
end
