class Puzzle < ApplicationRecord
  include Gridled

  has_many :games, dependent: :destroy
end
