class ContactsController < ApplicationController

  def index
    if current_admin
      @contacts = Contact.all
    elsif current_user
      redirect_to user_path(current_user), alert: '不正なアクセスです'
    else
      redirect_to root_path, alert: '会員登録、又はログインしてください'
    end
  end

  def show
    if current_admin
      @contact = Contact.find(params[:id])
    elsif current_user
      redirect_to user_path(current_user), alert: '不正なアクセスです'
    else
      redirect_to root_path, alert: '会員登録、又はログインしてください'
    end
  end

  def new
    if current_user
      @contact = Contact.new
    else
      redirect_to root_path, alert: '会員登録、又はログインしてください'
    end
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    @contact.save
    redirect_to user_path(@contact.user_id)
  end


  private
  def contact_params
    params.require(:contact).permit(:user_id, :title, :body)
  end

end
