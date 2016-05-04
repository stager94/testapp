class Status < ActiveRecord::Base

	def self.get
		first_or_create
	end

	def self.done!
		get.update_columns in_process: false, message: "OK"
	end

	def self.in_process!
		get.update_columns in_process: true, message: "Import in process.."
	end

	def self.failed!(message)
		get.update_columns in_process: false, message: message
	end

	def self.in_process?
		get.in_process?
	end

	def self.failed?
		!["OK", nil].include?(get.message) && !in_process?
	end

	def self.get_message
		get.message
	end

end
