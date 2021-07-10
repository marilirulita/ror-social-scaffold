class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def show
    @post = Post.new
    friends_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
  end

  def friends_posts
    @friends_posts ||= Post.where(user_id: friendship_btn(:user_id)).ordered_by_most_recent.includes(:user)
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def friendship_btn(user)
    friendship = Friendship.find_by(friend: user, user: current_user)
    friendship2 = Friendship.find_by(friend: current_user, user: user)
    if friendship || friendship2
      user
    else
      false
    end
  end
end
