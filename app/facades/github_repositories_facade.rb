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

  def user_github_followers
    @service.github_followers.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def user_github_following
    @service.github_user_following.map do |user_data|
      Following.new(user_data)
    end
  end

  def registered_user(github_user)
    return true if User.find_by(github_nickname: github_user)

  end

  def already_friends?(follower)
    friend = User.find_by(github_nickname: follower)
    return true if Friendship.find_by(user_id: user.id, friend_id: friend.id)
  end

  def bookmarked_tutorials
    user.bookmarks
  end

private

  attr_reader :user
end
