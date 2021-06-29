require 'test_helper'

class PuzzleTest < ActiveSupport::TestCase
  # test "the grid should be "

  test 'the grid should be 9x9 ' do
    puzzle = Puzzle.new
    assert puzzle.invalid?, 'Valid with empty grid size'
    puzzle.grid = ' ' * 9 * 9
    assert puzzle.valid?, 'Not valid with correct grid size'
    puzzle.grid = ' ' * 10
    assert puzzle.invalid?, 'Valid with wrong grid size'
  end

  test 'the grid should only contain numbers or spaces' do
    puzzle = Puzzle.new
    puzzle.grid = ' ' * 9 * 9
    assert puzzle.valid?, 'Not valid with empty grid'
    puzzle.grid[3] = '3'
    assert puzzle.valid?, 'Not valid with number in grid'
    puzzle.grid[8] = 'a'
    assert puzzle.invalid?, 'Valid with letter in grid'
    puzzle.grid[8] = '0'
    assert puzzle.invalid?, 'Valid with 0 in grid'
  end

  test 'the grid should have at least a solution' do
    puzzle = Puzzle.new(grid: "\
123456789\
456789123\
789123456\
234567891\
567891234\
891234567\
345678912\
678912345\
912345678\
")
    assert puzzle.valid?, 'Not valid with correctly filled solution'

    puzzle = Puzzle.new(grid: "\
2       2\
         \
         \
         \
         \
         \
         \
         \
         \
")
    puzzle.grid[0] = '2'
    refute puzzle.valid?, 'Valid with repeated numbers in row'
    assert_equal ["'2' occurs more than once in row 1"], puzzle.errors.full_messages

    puzzle = Puzzle.new(grid: "\
2        \
         \
         \
         \
         \
         \
         \
         \
2        \
")
    puzzle.grid[0] = '2'
    refute puzzle.valid?, 'Valid with repeated numbers in column'
    assert_equal ["'2' occurs more than once in column 1"], puzzle.errors.full_messages

    puzzle = Puzzle.new(grid: "\
2        \
         \
  2      \
         \
         \
         \
         \
         \
         \
")
    puzzle.grid[0] = '2'
    refute puzzle.valid?, 'Valid with repeated numbers in block'
    assert_equal ["'2' occurs more than once in block (row: 1, column: 1)"], puzzle.errors.full_messages
  end
end
