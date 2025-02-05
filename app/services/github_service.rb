class GithubService
	def initialize(token)
		@token = token.nil? ? nil : "token " + token
	end

  def repository_data
    get_json("/user/repos")
  end

  def follower_data
    get_json("/user/followers")
  end

	def following_data
		get_json("/user/followers")
	end

	def user_lookup(handle)
		get_json("/users/#{handle}")
	end

  private

  def conn
    @_conn ||= Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = @token
      faraday.headers["Accept"] = "application/vnd.github.v3+json"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
