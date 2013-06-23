class Speaker < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :quotes

  def name=(str)
    write_attribute(:name, str.to_s.titleize)
  end
end
