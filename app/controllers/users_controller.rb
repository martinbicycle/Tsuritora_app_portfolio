class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    if current_admin
      @user = User.find(params[:id])
      @posts = Post.page(params[:page]).per(20)
    elsif current_user
      @user = User.find(params[:id])
      @posts = Post.page(params[:page]).per(20)
    elsif
      redirect_to root_path, alert: "ログインしてください"
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user), alert: '不正なアクセスです'
    end
    @tackles = Tackle.where(user_id: @user.id)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user), success: 'プロフィールを更新しました'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image, :fishing_history)
  end

end
