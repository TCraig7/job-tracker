class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts

  def self.companies_by_interest
    Company.select("companies.*, AVG(level_of_interest) AS avg_interest").joins(:jobs).group(:company_id, :id).order("avg_interest DESC").limit(3)
  end
end
