require 'rails_helper'

RSpec.describe "As a logged in user" do
  describe "When I visit /dashboard, I should see a section for 'Github'" do
    it "Under 'Github' I should see a list of 5 repositories with the name of each Repo linking to the repo on Github" do
      VCR.use_cassette('github_auth', record: :new_episodes) do

        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Github")

        within(first(".repo")) do
          expect(page).to have_css(".name")
        end
        save_and_open_page

      end
    end
  end
end
