class Friend < ActiveRecord::Base
  attr_accessible :friend, :friend_state, :user

  belongs_to :user

  def self.get_friend_requests_for(user_id)
    user = User.find(user_id)
    toReturn = []
    if user
      friends = user.get_friend_requests
      friends.each do |friend|
        user = User.find(friend.friend)
        toReturn << user
      end
    end
    return toReturn
  end
end
