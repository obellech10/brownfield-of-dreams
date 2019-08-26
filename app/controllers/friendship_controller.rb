class FriendshipController < ApplicationController
  def create
    friend = User.find_by(github_nickname: params[:github_nickname])
    current_user.friendships.create!(friend_id: friend.id)
    redirect_to dashboard_path
  end
end
