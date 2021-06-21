require 'test_helper'

class PuzzleTest < ActiveSupport::TestCase
  # test "the grid should be "

  test 'the grid should be 9x9 ' do
    puzzle = Puzzle.new
    assert_equal 9 * 9, puzzle.grid.size
    assert puzzle.valid?, 'Not valid with correct grid size'
    puzzle.grid = ' ' * 10
    assert puzzle.invalid?, 'Valid with wrong grid size'
  end

  test 'the grid should only contain numbers or spaces' do
    puzzle = Puzzle.new
    assert_equal ' ' * 81, puzzle.grid
    assert puzzle.valid?, 'Not valid with empty grid'
    puzzle.grid[3] = '3'
    assert puzzle.valid?, 'Not valid with number in grid'
    puzzle.grid[8] = 'a'
    assert puzzle.invalid?, 'Valid with letter in grid'
    puzzle.grid[8] = '0'
    assert puzzle.invalid?, 'Valid with 0 in grid'
  end
end
