class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password_digest, :password_salt

  # creates one to many association with quotes so we can call user.quotes 
  # on a user object (add a belongs to association to the quotes)
  has_many :quotes

end
