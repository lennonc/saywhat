class ChangeSpeakerToId < ActiveRecord::Migration
  def change
    remove_column :quotes, :speaker
    add_column :quotes, :speaker_id, :integer
  end
end
