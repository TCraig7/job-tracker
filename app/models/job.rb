class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company, dependent: :destroy
  belongs_to :category, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.count_by_location
    Job.group(:city).order("count_all DESC").count
  end

  def self.count_by_interest
    Job.group(:level_of_interest).order(level_of_interest: :desc).count
  end
end
