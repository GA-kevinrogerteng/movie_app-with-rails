class CreateMoviedbs < ActiveRecord::Migration
  def change
    create_table :moviedbs do |t|
      t.string :imdbID
      t.string :title
      t.string :year

      t.timestamps
    end
  end
end
