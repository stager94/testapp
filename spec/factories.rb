require 'digest/sha1'

FactoryGirl.define do
	sequence(:email) { |n| "user#{n}@mail.com" }
	sequence(:name) { |n| "User #{n}"  }
	sequence(:sha) { |n| Digest::SHA1.hexdigest n.to_s }
	sequence(:date) { DateTime.now - (1..10).to_a.sample.days }
	sequence(:message) { |n| "Message ##{n}" }

	factory :user do
		name
		email

		factory :user_with_commits do
			commits { Array.new(10) { build(:commit) } }
		end

		factory :user_with_several_commits do
			commits { Array.new(2) { build(:commit) } }
		end

	end

	factory :commit do
		sha
		message
		date
	end

end