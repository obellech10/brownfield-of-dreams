require 'rails_helper'

RSpec.describe "As a logged in user" do
  describe "I should see a section called followers under github" do
    it  "listing my followers" do
    json_response = File.open("./fixtures/github_followers.json")
    stub_request(:get, "https://api.github.com/user/repos")
      .to_return(status: 200, body: json_response)

      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Github")
      expect(page).to have_content("Follower")
      within(first(".follower")) do
        expect(page).to have_css(".login")
        expect(page).to have_link("tayjames")
      end
    end
  end
end
