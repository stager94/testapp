class Commit < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :date, :sha, :user

  scope :ordered, -> { order date: :desc }
  scope :by_user_email, ->(email) { email.present? ? includes(:user).where(users: { email: email }) : all }
end
