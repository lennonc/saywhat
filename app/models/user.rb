class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation

  # creates one to many association with quotes so we can call user.quotes 
  # on a user object (add a belongs to association to the quotes)
  has_many :quotes

  attr_accessor :password
  #validations
  validates_presence_of     :first_name, :last_name, :email
  validates_presence_of     :password, :on => :create
  validates_uniqueness_of   :email
  validates_confirmation_of :password

  before_save :encrypt_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_digest == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt    = BCrypt::Engine.generate_salt
      self.password_digest  = BCrypt::Engine.hash_secret(password, password_salt)
    end  
  end
  
end
