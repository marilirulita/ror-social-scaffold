class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friendship = Friendship.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friendship = Friendship.new
    @friendships = Friendship.all
    @friends = friends
    @friend_requests = Friendship.friend_requests
  end

  def Friendship.friend_requests
    where(status: nil)
  end

  def friends
    friendships = Friendship.all
    friends_array = []
    friendships.map do |friendship| 
      if current_user.id == friendship.user_id && friendship.status
        friends_array.push(friendship.friend)
      end
    end
    friendships.map do |friendship| 
      if current_user.id == friendship.friend_id && friendship.status
        friends_array.push(friendship.user)
      end
    end
    friends_array
  end

  def friend?(user)
    friends.include?(user)
  end
end
