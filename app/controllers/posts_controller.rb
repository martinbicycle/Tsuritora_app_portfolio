class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @user = User.find(params[:id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@post)
  end

  private
    def post_params
      params.require(:post).permit(:name, :body, :image, :size, :fish_time, :address, :latitude, :longitude, :lure)
    end

end
