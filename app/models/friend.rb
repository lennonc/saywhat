class Friend < ActiveRecord::Base
  attr_accessible :friend, :friend_state, :user

  belongs_to :user
end
