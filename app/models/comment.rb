class Comment < ApplicationRecord
  belongs_to :job, dependent: :destroy
  validates_presence_of :content
end
