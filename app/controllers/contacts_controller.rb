class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    @contact.company_id = params[:company_id]
    @contact.save

    redirect_to company_path(@contact.company_id)
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :position, :email)
  end
end
