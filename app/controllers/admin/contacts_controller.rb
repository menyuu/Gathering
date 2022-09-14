class Admin::ContactsController < ApplicationController
  def index
    @contacts = Contact.page(params[:page]).without_count.per(5)
    case params[:contact_search]
    when "unread"
      @contacts = Contact.where(status: "unread").page(params[:page]).without_count.per(5)
    when "read"
      @contacts = Contact.where(status: "read").page(params[:page]).without_count.per(5)
    when "hold"
      @contacts = Contact.where(status: "hold").page(params[:page]).without_count.per(5)
    when "working"
      @contacts = Contact.where(status: "working").page(params[:page]).without_count.per(5)
    when "resolved"
      @contacts = Contact.where(status: "resolved").page(params[:page]).without_count.per(5)
    end
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
