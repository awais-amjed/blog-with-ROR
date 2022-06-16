class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    like = Like.new
    like.post_id = @post.id
    like.user_id = @user.id
    if like.save
      flash[:success] = 'Like saved successfully'
    else
      flash[:error] = 'Error: Like could not be saved'
    end
    redirect_to user_post_path(@user, @post)
  end
end
