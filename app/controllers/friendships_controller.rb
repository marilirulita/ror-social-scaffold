class FriendshipsController < ApplicationController

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      redirect_to users_path, notice: 'Post was successfully created.'
    else
      render :new, alert: 'Post was not created.'
    end
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
