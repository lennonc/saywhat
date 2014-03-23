class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation
  PHOTO_SIZE = '500'

  # creates one to many association with quotes so we can call user.quotes
  # on a user object (add a belongs to association to the quotes)
  has_many :quotes

  attr_accessor :password
  #validations
  # validates_presence_of     :first_name, :last_name, :email
  # validates_presence_of     :password, :on => :create
  # validates_uniqueness_of   :email
  # validates_confirmation_of :password

  before_save :get_additional_info


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      # user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def reconnect_with_facebook()

  end

  def profile_photo
    graph = get_graph
    image_url = graph.get_picture('me', :width => PHOTO_SIZE, :height => PHOTO_SIZE)
    image_url
  end

  def get_additional_info
    graph = get_graph
    info = graph.get_object('me')
    self.email = info['email']
    self.first_name = info['first_name']
    self.last_name = info['last_name']
  end

  # def self.authenticate(email, password)
  #   user = find_by_email(email)
  #   if user && user.password_digest == BCrypt::Engine.hash_secret(password, user.password_salt)
  #     user
  #   else
  #     nil
  #   end
  # end

  # def encrypt_password
  #   if password.present?
  #     self.password_salt    = BCrypt::Engine.generate_salt
  #     self.password_digest  = BCrypt::Engine.hash_secret(password, password_salt)
  #   end
  # end

  def name
    self.first_name + " " + self.last_name
  end

  private

  def get_graph
    graph = Koala::Facebook::API.new(self.oauth_token)
  end
end
