class ContactsController < ApplicationController

  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
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
