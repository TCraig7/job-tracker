class JobsController < ApplicationController
  before_action :set_job, only: [:show, :destroy, :edit, :update]

  def index
    if params[:company_id]
      company = Company.find(params[:company_id])
      if params[:sort]
        @jobs = company.jobs.sort_by_interest
      elsif params[:location]
        @jobs = company.jobs.filter_by_location(params[:location])
      else
        @jobs = company.jobs
      end
    elsif params[:location]
      @jobs = Job.filter_by_location(params[:location])
    elsif params[:sort]
      @jobs = Job.sort_by_interest
    else
      @jobs = Job.all
    end
    @header = "All Jobs"
  end

  def new
    @categories = Category.all
    @companies = Company.all
    @job = Job.new
    @header = "Create a new job!"
  end

  def create
    job = Job.new(job_params)
    if job.save
      flash[:success] = "You created #{job.title} at #{job.company.name}"
      redirect_to job_path(job)
    else
      flash[:failure] = "Job #{job.title} already exists!"
      redirect_to new_job_path
    end
  end

  def show
    @comment = @job.comments.new
    @header = "#{@job.title}"
  end

  def edit
    @categories = Category.all
    @companies  = Company.all
    @header = "Edit Job '#{@job.title}'"
  end

  def update
    @job.update(job_params)

    redirect_to job_path(@job)
  end

  def destroy
    @job.destroy

    redirect_to jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :company_id, :category_id)
  end

  def set_job
    @job = Job.find(params[:id])
  end
end
