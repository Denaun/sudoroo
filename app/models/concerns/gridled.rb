module Gridled
  extend ActiveSupport::Concern

  included do
    GRID_SIDE_LENGTH = 9
    GRID_SIZE = GRID_SIDE_LENGTH**2

    validates :grid, length: { is: GRID_SIZE }, format: { with: /\A[ 1-9]*\z/ }
  end
end
