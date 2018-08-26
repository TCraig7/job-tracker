class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = "#{@company.name} added!"
      redirect_to company_path(@company)
    else
      flash[:failure] = "Company '#{params[:company][:name]}' already exists!"
      redirect_to new_company_path
    end
  end

  def show
    company = Company.find(params[:id])
    redirect_to company_jobs_path(company)
  end

  def edit
    @company = Company.find(params[:id])
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
