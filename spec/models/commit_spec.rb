require 'spec_helper'
require 'rails_helper'

describe Commit do

	it { should belong_to :user }
	it { should validate_presence_of :sha }
	it { should validate_presence_of :user }
	it { should validate_presence_of :date }

	it "should return only one person commits" do
		user1 = create :user_with_commits
		user2 = create :user_with_commits

		result = Commit.by_user_email(user1.email)
		user_ids = result.map(&:user_id).uniq

		expect(result.count).to eq 10
		expect(user_ids).to eq [user1.id]
	end

	it "should order commits per commit date" do
		user = create :user_with_several_commits

		result = Commit.ordered
		
		expect(result[0].date).to be > result[1].date
	end

end