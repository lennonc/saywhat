class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation
  PHOTO_SIZE = '500'

  # creates one to many association with quotes so we can call user.quotes
  # on a user object (add a belongs to association to the quotes)
  has_many :quotes
  has_many :friends

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
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def get_additional_info
    info = self.facebook.get_object('me')
    self.email = info['email']
    self.first_name = info['first_name']
    self.last_name = info['last_name']
    self.photo = self.facebook.get_picture('me', :width => PHOTO_SIZE, :height => PHOTO_SIZE)
  end

  def get_friends
    friends = self.friends.where(:accepted => true).all
    toReturn = []
    friends.each do |friend|
      user = User.find(friend.friend)
      toReturn << user
    end
    toReturn
  end

  def get_other_users
    users = User.all
    users.delete(self)
    self.get_friends.each do |friend|
      users.delete(friend)
    end
    self.get_friend_requests.each do |friend|
      friend = User.find(friend.friend)
      users.delete(friend)
    end
    users
  end

  def make_friends

  end

  def get_friend_requests
    friends = self.friends.where(:accepted => false).all
  end

  def send_friend_request(potential_friend)
    # Check to see if a user is already friends with that person
    # If so do nothing else
    # create a friend record
    new_friend = User.find_by_id(potential_friend)
    friend = Friend.new
    friend.user_id = self.id
    friend.friend = new_friend.id
    friend.accepted = false
    friend.save!
    # TODO Send notification to the would be friend
    # Notification center maybe?
  end

  def respond_to_friend_request(response, request_id)
    if response == 'accept'
      a = Friend.find(request_id)
      a.accepted = true
      a.save!
    else
      Friend.delete(request_id)
    end

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

  def facebook
    @facebook = Koala::Facebook::API.new(self.oauth_token)
  end
end
