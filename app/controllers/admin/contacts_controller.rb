class Admin::ContactsController < ApplicationController
  def index
    @contacts = Contact.page(params[:page]).without_count.per(5)
  end

  def show
    @contact = Contact.find(params[:id])
    if @contact.unread?
      @contact.update(status: "read")
    end
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update!(contact_params)
    redirect_to request.referer
  end

  private

  def contact_params
    params.require(:contact).permit(:status)
  end
end
