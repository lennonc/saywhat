class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.integer :friend
      t.boolean :accepted

      t.timestamps
    end
  end
end
