class Speaker < ActiveRecord::Base
  attr_accessible :name

  has_many :quotes
end