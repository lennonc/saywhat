class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :name

  # creates one to many association with quotes so we can call user.quotes
  # on a user object (add a belongs to association to the quotes)
  has_many :quotes

  attr_accessor :password
  #validations
  # validates_presence_of     :first_name, :last_name, :email
  # validates_presence_of     :password, :on => :create
  # validates_uniqueness_of   :email
  # validates_confirmation_of :password

  # before_save :encrypt_password

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

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

  def full_name
    first_name + " " + last_name
  end

end
