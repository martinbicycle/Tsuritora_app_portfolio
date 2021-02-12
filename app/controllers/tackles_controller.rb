class TacklesController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @tackle = Tackle.new
  end

  def create
    @user = current_user
    @tackle = Tackle.new(tackle_params)
    @tackle.user_id = current_user.id
    if @tackle.save
     redirect_to edit_user_path(@user), success: "追加しました"
    else
      redirect_to new_user_tackle_path(@user), alert: "釣り具が入力されていません"
    end

  end

  def destroy
    @user = current_user
    @tackle = Tackle.find(params[:id])
    @tackle.destroy
    redirect_to edit_user_path(@user)
  end

  private
    def tackle_params
      params.require(:tackle).permit(:name)
    end

end
