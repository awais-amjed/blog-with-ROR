class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @all_posts = @user.posts.includes(:comments).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
    end
  end

  def create
    @user = current_user
    post = Post.new(params.require(:post).permit(:text, :title))
    post.user_id = @user.id
    post.comments_counter = 0
    post.likes_counter = 0
    respond_to do |format|
      format.html do
        if post.save
          post.increment_counter
          flash[:success] = 'Post saved successfully'
          redirect_to user_posts_path(@user)
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render :new, locals: { post: }
        end
      end
    end
  end
end
