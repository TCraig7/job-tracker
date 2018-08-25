class Comment < ApplicationRecord
  belongs_to :job
  validate_presence_of :content
end
