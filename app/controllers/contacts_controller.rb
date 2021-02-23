class ContactsController < ApplicationController

  def index
    if current_admin
      @contacts = Contact.all
      @contacts = Contact.page(params[:page]).per(10)
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
    if @contact.save
      redirect_to user_path(@contact.user_id), success: "送信しました"
    else
      render :new
    end
  end

  def update
     contact = Contact.find(params[:format])
     if contact.checkflag.present?
       contact.update(checkflag: false)
       redirect_to contacts_path, alert: "未確認にしました"
     else
       contact.update(checkflag: true)
       redirect_to contacts_path, success: "確認にしました"
     end
  end

  private
  def contact_params
    params.require(:contact).permit(:user_id, :title, :body)
  end

end
