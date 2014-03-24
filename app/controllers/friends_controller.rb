class FriendsController < ApplicationController
  def index
    @friends = current_user.get_friends
    @pending_friends = Friend.get_friend_requests_for(current_user.id)
  end
end