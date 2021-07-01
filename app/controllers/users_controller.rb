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
    @friends = Friendship.friends
    @friend_requests = Friendship.friend_requests
  end

  def Friendship.friends
    where(status: true)
  end

  def Friendship.friend_requests
    where(status: nil)
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
