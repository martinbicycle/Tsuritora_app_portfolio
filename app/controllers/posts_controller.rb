class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
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
    @tackles = current_user.tackles
    @post = Post.new(post_params)
    tag_list = params[:post][:tag_ids].split(',')
    @post.user_id = current_user.id
    if @post.save
      params[:post][:tackle].each do |tackle|
      post_tackle = PostTackle.new(post_id: @post.id, tackle_id: tackle)
      post_tackle.save
      end
      @post.save_tags(tag_list)
      redirect_to post_path(@post)
    else
      render :new
    end

  end

  def edit
    @tackles = current_user.tackles
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(",")
    if @post.user != current_user
      redirect_to posts_path, alert: '不正なアクセスです'
    end
  end

  def update
    @tackles = current_user.tackles
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_ids].split(',')
    @post.save_tags(tag_list)
    if @post.update_attributes(post_params)
      redirect_to post_path(@post), success: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@user), alert: "削除しました"
  end

  private
    def post_params
      params.require(:post).permit(
        :name, :body, :image, :size, :fish_time,
        :address, :latitude, :longitude, :lure,
        :wc, :parking, :convenience_store, :fishing_bait)
    end

end
