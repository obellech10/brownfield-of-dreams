require 'rails_helper'

RSpec.describe "User can see a list of users they follow" do
  describe "As a logged in user" do
    context "When I visit '/dashboard', I see a section for 'Github', under that I see a section 'Following'" do
      it "I should see a list of users I follow with their handles linking to their Github profile" do
        json_response = File.open("./fixtures/github_following.json")
        stub_request(:get, "https://api.github.com/user/following")
          .to_return(status: 200, body: json_response)

        user = User.create!(first_name: 'Dan', last_name: 'Mariano', password: 'test', github_token: 'test', email: 'dan@example.com')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Following")

        within(first(".user")) do
          expect(page).to have_css(".login")
        end
      end
    end
  end
end
