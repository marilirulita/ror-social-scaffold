class FriendshipsController < ApplicationController

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      redirect_to users_path, notice: 'Friendship request was successfully sent.'
    else
      redirect_to users_path, alert: 'You actually sent a friendship request.'
    end
  end

  private
  
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
