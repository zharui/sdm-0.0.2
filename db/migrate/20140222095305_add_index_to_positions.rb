class AddIndexToPositions < ActiveRecord::Migration
  def change
		add_index :positions, :name
		add_index :positions, :publisher_id
		add_index :positions, :channel_id
  end
end
