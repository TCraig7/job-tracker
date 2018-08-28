class DashboardController < ApplicationController
  def index
    @jobs_by_location = Job.count_by_location
    @companies_by_interest = Company.companies_by_interest
    @count_by_interest = Job.count_by_interest
    @header = 'Job Tracker Dashboard'
  end
end
