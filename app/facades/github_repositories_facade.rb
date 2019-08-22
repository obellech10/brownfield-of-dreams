class GithubRepositoriesFacade
  def initialize(user)
    @user = user
  end

  def user_github_repos
    service = GithubService.new
    service.github_user_repos.map do |user_data|
      Repository.new(user_data)
    end
  end

  def user_github_followers
    service = GithubService.new
    service.github_followers.map do |follower_data|
      Follower.new(follower_data)
    end 
  end

  private

  attr_reader :user
end
