class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.string :startpoint
      t.string :endpoint
      t.integer :distance
      t.timestamps
    end
  end
end
