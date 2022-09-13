class EndUser::ContactsController < ApplicationController
  before_action :notification_index, only: [:new, :confirm, :done]
  
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render :new
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if params[:back] || !@contact.save
      render :new and return
    else
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to contacts_done_path
    end
  end

  def done
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
