class GithubRepositoriesFacade
  def initialize(user)
    @user    = user
    @service = GithubService.new
  end

  def user_github_repos
    @service.github_user_repos.map do |user_data|
      Repository.new(user_data)
    end
  end

  def user_github_following
    @service.github_user_following.map do |user_data|
      Following.new(user_data)
    end
  end

  private
  attr_reader :user
end
