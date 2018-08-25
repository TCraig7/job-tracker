class JobsController < ApplicationController
  before_action :set_job_and_company, only: [:show, :destroy, :edit, :update]

  def index
    @company = Company.find(params[:company_id])
    @jobs = @company.jobs
  end

  def new
    @categories = Category.all
    @company = Company.find(params[:company_id])
    @job = Job.new
  end

  def create
    @company = Company.find(params[:company_id])
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to company_job_path(@company, @job)
    else
      flash[:failure] = "Job #{@job.title} already exists!"
      redirect_to new_company_job_path(@company)
    end
  end

  def show
    @comment = Comment.new
    @comment.job_id = @job.id
  end

  def edit
    @categories = Category.all
  end

  def update
    @job.update(job_params)

    redirect_to company_job_path(@company, @job)
  end

  def destroy
    @job.destroy

    redirect_to company_path(@company)
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id)
  end

  def set_job_and_company
    @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
  end
end
