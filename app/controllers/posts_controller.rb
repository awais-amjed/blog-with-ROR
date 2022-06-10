class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @recent_posts = @user.recent_posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def get_user_name(user_id)
    User.find(user_id).name
  end

  def get_all_comments(post_id)
    Comment.where(post_id:)
  end

  helper_method :get_user_name, :get_all_comments
end
