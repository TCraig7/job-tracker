class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    @header = "Companies"
  end

  def new
    @company = Company.new
    @header = "Create a new company here!"
  end

  def create
    company = Company.new(company_params)
    if company.save
      flash[:success] = "#{company.name} added!"
      redirect_to company_path(company)
    else
      flash[:failure] = "Company '#{params[:company][:name]}' already exists!"
      redirect_to new_company_path
    end
  end

  def show
    @company = Company.find(params[:id])
    @contact = Contact.new
    @contact.company_id = @company.id
    @header = "Contact Information for #{@company.name}"
  end

  def edit
    @company = Company.find(params[:id])
    @header = "Edit #{@company.name} here!"
  end

  def update
    company = Company.find(params[:id])
    company.update(company_params)
    if company.save
      flash[:success] = "#{company.name} updated!"
      redirect_to company_path(company)
    else
      flash[:failure] = "Company '#{params[:company][:name]}' already exists!"
      redirect_to edit_company_path(company)
    end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy

    flash[:success] = "#{company.name} was successfully deleted!"
    redirect_to companies_path
  end


  private

  def company_params
    params.require(:company).permit(:name, :city)
  end
end
