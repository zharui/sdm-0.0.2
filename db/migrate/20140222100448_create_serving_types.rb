class CreateServingTypes < ActiveRecord::Migration
  def change
    create_table :serving_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
