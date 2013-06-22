class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name

      t.timestamps
    end

    remove_column :quotes, :speaker
    add_column :quotes, :speaker_id, :integer

  end
end
