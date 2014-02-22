class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
			t.string :name
			t.string :url
			t.integer :state_id
			t.integer :publisher_id
			t.integer :tag_ids, array: true, default: []
			t.integer :user_id
      t.timestamps
    end
		add_index :channels, :name, unique: true
		add_index :channels, :publisher_id
  end
end
