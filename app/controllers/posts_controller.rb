class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    tackleids = PostTackle.where(post_id: params[:id] ).pluck(:tackle_id)
    @tackles = Tackle.where(id: tackleids).pluck(:name).join(',')
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @tackles = current_user.tackles
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    params[:post][:tackle].each do |tackle|
      post_tackle = PostTackle.new(post_id: @post.id, tackle_id: tackle)
      post_tackle.save
    end
    redirect_to post_path(@post)
  end

  def edit
    @tackles = current_user.tackles
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@user)
  end

  private
    def post_params
      params.require(:post).permit(
        :name, :body, :image, :size, :fish_time,
        :address, :latitude, :longitude, :lure)
    end

end
