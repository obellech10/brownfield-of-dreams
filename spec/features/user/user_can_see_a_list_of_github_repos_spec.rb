require 'rails_helper'

RSpec.describe "As a logged in user" do
  describe "When I visit /dashboard, I should see a section for 'Github'" do
    describe "Under 'Github' I should see a list of 5 repositories with the name of each Repo linking to the repo on Github" do
      before :each do
        json_response = File.open("./fixtures/github_repos.json")
        stub_request(:get, "https://api.github.com/user/repos")
          .to_return(status: 200, body: json_response)
      end

      scenario 'If the user has connected to github' do
        user = User.create!(first_name: 'Dan', last_name: 'Mariano', password: 'test', github_token: 'test', email: 'dan@example.com')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Github")

        within(first(".repo")) do
          expect(page).to have_css(".name")
        end
      end

      scenario 'If the user has connected to github' do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(current_path).to eq(dashboard_path)

        expect(page).to_not have_content("Github")
      end
    end
  end
end
