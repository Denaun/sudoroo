module Celled
  extend ActiveSupport::Concern

  private

  def build_grid(params)
    cells = params.delete :cells
    if cells
      params[:grid] = cells[(1...cells.length).step(2)]
                      .map { |c| c.empty? ? ' ' : c }.join('')
    end
    params
  end
end
