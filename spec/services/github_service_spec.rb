require 'rails_helper'

describe GithubService do
  context "Instance methods" do
    context "#github_user_repos" do
      it "Returns a user's github repositories" do
        search =  subject.github_user_repos
        expect(search).to be_a Array
        user_data = search.first
        expect(user_data).to have_key :name
        expect(user_data).to have_key :html_url
      end
    end
  end
end
