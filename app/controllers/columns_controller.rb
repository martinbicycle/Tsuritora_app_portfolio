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
    @column.save
    redirect_to column_path(@column)
  end

  def edit
    @column = Column.find(params[:id])
  end

  def update
    @column = Column.find(params[:id])
    @column.update(column_params)
    redirect_to column_path(@column)

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
