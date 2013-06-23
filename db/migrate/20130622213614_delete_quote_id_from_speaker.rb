class DeleteQuoteIdFromSpeaker < ActiveRecord::Migration
  def change
    remove_column :speakers, :quote_id
  end
end
