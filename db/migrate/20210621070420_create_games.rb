class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.belongs_to :puzzle, null: false, foreign_key: true
      t.string :grid

      t.timestamps
    end
  end
end
