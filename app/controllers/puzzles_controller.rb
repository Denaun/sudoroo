class PuzzlesController < ApplicationController
  before_action :set_puzzle, only: %i[show edit update destroy]

  def index
    @puzzles = Puzzle.all
  end

  def show; end

  def new
    @puzzle = Puzzle.new
  end

  def edit; end

  def create
    @puzzle = Puzzle.new(puzzle_params)

    respond_to do |format|
      if @puzzle.save
        format.html { redirect_to @puzzle, notice: 'Puzzle was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @puzzle.update(puzzle_params)
        format.html { redirect_to @puzzle, notice: 'Puzzle was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_puzzle
    @puzzle = Puzzle.find(params[:id])
  end

  def puzzle_params
    p = params.require(:puzzle)
    Rails.logger.debug(p)
    cells = p.delete :cells
    if cells
      p[:grid] = cells[(1...cells.length).step(2)]
                 .map { |c| c.empty? ? ' ' : c }.join('')
    end
    p.permit(:grid)
  end
end
