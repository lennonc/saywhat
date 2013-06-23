class AddSpeakerPhoto < ActiveRecord::Migration
  def change
    add_column :speakers, :photo, :binary
  end
end
