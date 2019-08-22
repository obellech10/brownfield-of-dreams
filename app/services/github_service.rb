class GithubService
  def github_user_repos
    get_json("/user/repos")
  end

  def github_followers
    get_json("/user/followers")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true).take(5)
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = ENV['USER_GITHUB_API_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end
end
