module Gridled
  extend ActiveSupport::Concern

  BLOCK_SIDE_LENGTH = 3
  BLOCKS_PER_SIDE = 3
  GRID_SIDE_LENGTH = BLOCK_SIDE_LENGTH * BLOCKS_PER_SIDE
  GRID_SIZE = GRID_SIDE_LENGTH**2

  included do
    validates :grid, length: { is: GRID_SIZE }, format: { with: /\A[ 1-9]*\z/ }
  end
end
