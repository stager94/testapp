class Commit < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :date, :sha, :user
end
