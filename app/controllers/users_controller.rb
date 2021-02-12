class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
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
    redirect_to user_path(@user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image, :fishing_history)
  end

end
