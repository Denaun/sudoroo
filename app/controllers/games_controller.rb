class GamesController < ApplicationController
  include Celled

  before_action :set_puzzle
  before_action :set_game, only: %i[show edit update destroy]

  # GET /games or /games.json
  def index
    @games = @puzzle.games
  end

  # GET /games/1 or /games/1.json
  def show; end

  # GET /games/new
  def new
    @game = @puzzle.games.build
    @game.grid = @puzzle.grid
  end

  # GET /games/1/edit
  def edit; end

  # POST /games or /games.json
  def create
    @game = @puzzle.games.build(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to [@puzzle, @game], notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to [@puzzle, @game], notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to puzzle_games_path(@puzzle), notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = @puzzle.games.find(params[:id])
  end

  def set_puzzle
    @puzzle = Puzzle.find(params[:puzzle_id])
  end

  # Only allow a list of trusted parameters through.
  def game_params
    build_grid(params.fetch(:game, :cells)).permit(:grid)
  end
end
