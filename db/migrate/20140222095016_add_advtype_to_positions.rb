class AddAdvtypeToPositions < ActiveRecord::Migration
  def change
		add_column :positions, :adtype_id, :integer
  end
end
