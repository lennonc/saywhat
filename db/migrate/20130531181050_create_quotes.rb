class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :user_id
      t.string :quote
      t.string :speaker
      t.datetime :date_of_quote

      t.timestamps
    end
  end
end
