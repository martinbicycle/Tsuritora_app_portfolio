class ColumnsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @columns = Column.all
  end

  def show
    @column = Column.find(params[:id])
  end

  def new
    @column = Column.new
  end

  def create
    @column = Column.new(column_params)
    @column.admin_id = current_admin.id
    if @column.save
      redirect_to column_path(@column), success: '投稿しました'
    else
      redirect_to new_column_path, alert: '入力されていない項目があります'
    end
  end

  def edit
    @column = Column.find(params[:id])
  end

  def update
    @column = Column.find(params[:id])
    if @column.update(column_params)
      redirect_to column_path(@column), success: '更新しました'
    else
      render :edit
    end

  end

  def destroy
    @admin = current_admin
    @column = Column.find(params[:id])
    @column.destroy
    redirect_to columns_path
  end


  private
  def column_params
    params.require(:column).permit(:admin_id, :title, :body, :image)
  end

end
