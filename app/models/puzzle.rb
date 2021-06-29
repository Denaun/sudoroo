class SolutionExistenceValidator < ActiveModel::Validator
  def validate(record)
    return if record.grid.blank?

    record.grid.chars.each_slice(Puzzle::GRID_SIDE_LENGTH).with_index do |row, row_ix|
      repetitions(row).each do |c|
        record.errors.add :base, "'#{c}' occurs more than once in row #{row_ix + 1}"
      end
    end
    Puzzle::GRID_SIDE_LENGTH.times do |col_ix|
      col = record.grid.chars[(col_ix...record.grid.length).step(Puzzle::GRID_SIDE_LENGTH)]
      repetitions(col).each do |c|
        record.errors.add :base, "'#{c}' occurs more than once in column #{col_ix + 1}"
      end
    end
    Puzzle::BLOCKS_PER_SIDE.times do |block_col_ix|
      block_col = block_col_ix * Puzzle::BLOCK_SIDE_LENGTH
      Puzzle::BLOCKS_PER_SIDE.times do |block_row_ix|
        block_row = block_row_ix * Puzzle::BLOCK_SIDE_LENGTH * Puzzle::GRID_SIDE_LENGTH
        top_left = block_col + block_row
        block = Puzzle::BLOCK_SIDE_LENGTH.times.reduce([]) do |block, inner_row_ix|
          row_start = top_left + inner_row_ix * Puzzle::GRID_SIDE_LENGTH
          block + record.grid.chars[row_start...row_start + Puzzle::BLOCK_SIDE_LENGTH]
        end
        repetitions(block).each do |c|
          record.errors.add :base,
                            "'#{c}' occurs more than once in block (row: #{block_row_ix + 1}, column: #{block_col_ix + 1})"
        end
      end
    end
  end

  private

  def repetitions(section)
    section
      .reject { |c| c == ' ' }
      .group_by(&:itself)
      .filter_map { |c, reps| c if reps.size > 1 }
  end
end

class Puzzle < ApplicationRecord
  include Gridled

  has_many :games, dependent: :destroy
  validates_with SolutionExistenceValidator
end
