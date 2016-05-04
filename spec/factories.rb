FactoryGirl.define do
	# sequence(:email) { |n| "user#{n}@mail.com" }
	# sequence(:name) { |n| "User #{n}"  }

	factory :user do
		name "MarRyb"
		email "marryb@macbook-pro-marryb.local"
	end
	
end