class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :user, presence: true, uniqueness: {scope: :project}, allow_nil: false
  validates :content, presence: true
end
