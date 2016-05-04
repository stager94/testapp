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
		let(:json_example) { load_json_for "test_commits" }

		it 'should generate properly URL' do
			url = importer.send :build_url
			expect(url).to eq "https://api.github.com/repos/stager94/test_commits/commits"
		end

		it 'should clear DB' do
			create :user_with_commits

			importer.send :clear_database

			expect(User.count).to eq 0
			expect(Commit.count).to eq 0
		end

		it 'should generate properly JSON' do
			response = importer.send :commits

			expect(response).to eq json_example
		end

		it 'should generate properly user params' do
			example_commit = json_example[0]
			result = importer.send(:prepare_user_params, example_commit).with_indifferent_access
			good_params = load_json_for("good_user_params").with_indifferent_access

			expect(result).to include good_params
		end

		it 'should generate properly commit params' do
			example_commit = json_example[0]
			result = importer.send(:prepare_commit_params, example_commit).with_indifferent_access
			good_params = load_json_for("good_commit_params").with_indifferent_access

			expect(result).to include good_params
		end

	end

end