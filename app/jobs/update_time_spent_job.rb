class UpdateTimeSpentJob < ApplicationJob
  queue_as :low_priority

  def perform(*_args)
    Game.find_each do |game|
      game.touch unless game.finished?
    end
  end
end
