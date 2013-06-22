class Speaker < ActiveRecord::Base
  attr_accessible :name
  validates_uniqueness_of :name

  has_many :quotes
end
