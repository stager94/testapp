class Commit < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :date, :sha, :user

  scope :by_date, -> { order date: :desc }
end
