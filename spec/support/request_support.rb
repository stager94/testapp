def load_json_for(filename)
	path = Rails.root.join *%W[spec data #{filename}.json]
	json = File.open(path).read
	JSON.parse json, { symbolized_names: true }
end