module GitHub
	class Importer < BasicModule
		
		URL_REGEX = /<([^<]*)>/
		REL_REGEX = /rel="([^"]*)"/

		# can get [username, repository_name] params or just [url]
		attr_reader :username, :repository_name, :url, :dont_touch_db

		def execute
			clear_database if dont_touch_db != true
			Status.in_process! if !Status.in_process?
			GitHub::Importer.new(url: next_page_url, dont_touch_db: true).delay.execute if next_page_url
			commits.each {|commit| process commit }
			Status.done! if !next_page_url
		end

	private

		def build_url
			url ? url : "https://api.github.com/repos/#{username}/#{repository_name}/commits"
		end

		def response
			@_response ||= (
				begin
					RestClient.get(build_url)	
				rescue Exception => e
					Status.failed! JSON.parse(e.response)["message"]
				end
			)
		end

		def commits
			@_commits ||= JSON.parse response
		end

		def clear_database
			Commit.delete_all
			User.delete_all
		end

		def process(commit)
			user = User.where(prepare_user_params(commit)).first_or_create
			user.commits.create prepare_commit_params(commit)
		end

		def prepare_user_params(commit)
			{
				email: commit["commit"]["author"]["email"],
				name: commit["commit"]["author"]["name"]
			}
		end

		def prepare_commit_params(commit)
			binding.pry
			{
				sha: commit["sha"],
				date: Time.parse(commit["commit"]["author"]["date"]),
				message: commit["commit"]["message"]
			}
		end

		def header_links
			@_header_links ||= (
				links = response.headers[:link].split(", ")
				links.inject({}) do |res, link|
					url = link.match(URL_REGEX)[1]
					rel = link.match(REL_REGEX)[1]
					res[rel] = url
					res
				end
			)
		end

		def next_page_url
			header_links["next"]
		end

	end
end