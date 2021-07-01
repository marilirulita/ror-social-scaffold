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

  def edit
    @friendship = Friendship.find(params[:id])
  end

  def update
    @friendship = Friendship.find(params[:id])

    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to users_path, notice: 'Friend was successfully updated.' }
        format.json { render :show, status: :ok, location: users_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: users_path.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
