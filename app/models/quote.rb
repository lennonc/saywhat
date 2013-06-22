class Quote < ActiveRecord::Base
  attr_accessible :date_of_quote, :quote, :speaker_id, :user_id

  
  validates_presence_of :date_of_quote, :quote, :speaker_id, :user_id

  # validate the date later make sure it's not greater than today's date
  belongs_to :user
  belongs_to :speaker


end
