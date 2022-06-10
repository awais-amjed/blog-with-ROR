class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @recent_posts = @user.recent_posts
  end

  def show
    puts params
  end

  def get_user_name(user_id)
    User.find(user_id).name
  end

  helper_method :get_user_name
end
