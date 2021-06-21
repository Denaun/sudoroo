module Gridled
  extend ActiveSupport::Concern

  included do
    GRID_SIDE_LENGTH = 9
    GRID_SIZE = GRID_SIDE_LENGTH**2

    validates :grid, length: { is: GRID_SIZE }, format: { with: /\A[ 1-9]*\z/ }
    after_initialize :set_default
  end

  private

  def set_default
    self.grid = ' ' * GRID_SIZE
  end
end
