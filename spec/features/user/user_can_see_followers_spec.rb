require 'rails_helper'

RSpec.describe "As a logged in user" do
  describe "I should see a section called followers under github" do
    describe  "listing my followers" do
      before :each do
        json_response = File.open("./fixtures/github_followers.json")
        stub_request(:get, "https://api.github.com/user/repos")
        .to_return(status: 200, body: json_response)
      end

      scenario 'If the user has connected to github' do
        user = User.create!(first_name: 'Dan', last_name: 'Mariano', password: 'test', github_token: 'test', email: 'dan@example.com')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Github")
        expect(page).to have_content("Follower")
        within(first(".follower")) do
          expect(page).to have_css(".login")
        end
      end

      scenario 'If the user has not connected to github' do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(current_path).to eq(dashboard_path)

        expect(page).to_not have_content("Github")
      end
    end
  end
end
