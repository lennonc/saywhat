class Speaker < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :name
      t.integer :quote_id

      t.timestamps
    end
  end
end
