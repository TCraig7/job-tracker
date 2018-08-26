class DashboardsController < ApplicationController
  def index
    @jobs_by_location = Job.count_by_location
  end
end
