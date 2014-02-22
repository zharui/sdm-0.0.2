class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
			t.string :name
			t.string :url
			t.integer :state_id
			t.integer :publisher_id
			t.integer :channel_id
			t.integer :tag_ids, array: true, default: []
			t.integer :material_id
			t.integer :layout_id
			t.integer :dimension_id
			t.integer :format_id
			t.integer :serving_id
			t.integer :payment_id
			t.string :size
			t.integer :user_id
      t.timestamps
    end
  end
end
