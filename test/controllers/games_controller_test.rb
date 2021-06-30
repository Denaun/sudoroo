require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:one)
    @puzzle = @game.puzzle
  end

  test 'should get index' do
    get puzzle_games_url(@puzzle)
    assert_response :success
  end

  test 'should get new' do
    get new_puzzle_game_url(@puzzle)
    assert_response :success
  end

  test 'should create game' do
    assert_difference('Game.count') do
      post puzzle_games_url(@puzzle), params: { game: { cells: Array.new(81 * 2, ' ') } }
    end

    assert_redirected_to puzzle_game_url(@puzzle, Game.last)
  end

  test 'should show game' do
    get puzzle_game_url(@puzzle, @game)
    assert_response :success
  end

  test 'should get edit' do
    get edit_puzzle_game_url(@puzzle, @game)
    assert_response :success
  end

  test 'should update game' do
    patch puzzle_game_url(@puzzle, @game), params: { game: { cells: Array.new(81 * 2, ' ') } }
    assert_redirected_to puzzle_game_url(@puzzle, @game)
  end

  test 'should destroy game' do
    assert_difference('Game.count', -1) do
      delete puzzle_game_url(@puzzle, @game)
    end

    assert_redirected_to puzzle_games_url(@puzzle)
  end
end
