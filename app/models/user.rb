class User < ActiveRecord::Base

	has_many :commits

	validates_presence_of :name, :email

end
