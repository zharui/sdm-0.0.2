class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
			t.string :name
			t.string :url
			t.integer :state_id
			t.integer :tag_ids, array: true, default: []
			t.integer :user_id
      t.timestamps
    end
		add_index :publishers, :name, unique: true
  end
end
