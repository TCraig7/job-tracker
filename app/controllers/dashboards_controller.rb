class DashboardsController < ApplicationController
  def index
    @jobs_by_location = Job.count_by_location
    @companies_by_interest = Company.companies_by_interest
  end
end
