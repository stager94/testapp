require 'digest/sha1'

FactoryGirl.define do
	# sequence(:email) { |n| "user#{n}@mail.com" }
	# sequence(:name) { |n| "User #{n}"  }
	sequence(:sha) { |n| Digest::SHA1.hexdigest n.to_s }
	sequence(:date) { |n| DateTime.now - n.days }
	sequence(:message) { |n| "Message ##{n}" }

	factory :user do
		name "MarRyb"
		email "marryb@macbook-pro-marryb.local"

		factory :user_with_commits do
			commits { Array.new(10) { build(:commit) } }
		end

	end

	factory :commit do
		sha
		message
		date
	end

end