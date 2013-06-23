class Quote < ActiveRecord::Base
  attr_accessible :date_of_quote, :quote, :user_id, :speaker_id

  
  validates_presence_of :date_of_quote, :quote, :speaker_id, :user_id
  validate :date_is_not_in_future


  # validate the date later make sure it's not greater than today's date
  belongs_to :user
  belongs_to :speaker


  private
  def date_is_not_in_future
    if self.date_of_quote > Time.now
      self.errors[:date_of_quote] << "must not be in the future."
      false
    else
      true
    end
  end

end
