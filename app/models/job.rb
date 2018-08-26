class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company, dependent: :destroy
  belongs_to :category, dependent: :destroy
  has_many :comments, dependent: :destroy
end
