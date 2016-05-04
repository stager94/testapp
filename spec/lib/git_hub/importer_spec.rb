require 'spec_helper'
require 'rails_helper'

describe GitHub::Importer do
	subject(:importer) { described_class.new(username: "stager94", repository_name: "test_commits") }

	let(:user) { build(:user) }

	context 'processes associated objects' do
		it 'creates users' do
			expect{ 
				importer.execute 
			}.to change(::User, :count).by 1
		end

		it 'creates commits' do
			expect{ 
				importer.execute 
			}.to change(::Commit, :count).by 3
		end
	end

	context 'properly' do
		it 'should generate properly URL' do
			url = importer.send(:build_url)
			expect(url).to eq "https://api.github.com/repos/stager94/test_commits/commits"
		end

		it 'should clear DB' do
			create(:user)
			10.times { create(:commit) }
			importer.send(:clear_database)
			expect(User.count).to eq 0
			expect(Commit.count).to eq 0
		end
	end

end