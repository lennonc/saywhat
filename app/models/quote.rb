class Quote < ActiveRecord::Base
  attr_accessible :date_of_quote, :quote, :speaker, :user_id

  belongs_to :user
  
end
