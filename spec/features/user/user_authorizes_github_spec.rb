require 'rails_helper'

RSpec.describe "As a logged in user" do
  describe "when I visit the dashboard" do
    before :each do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        credentials: {
        :token => 'test'
        },
        info: {
          :nickname => 'obellech10'
        }
      )

      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    end
    it "I can click a button to connect to Github, then I'm redirected to my dashboard" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      click_button 'Connect to Github'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Github")

      within(first(".repo")) do
        expect(page).to have_css(".name")
      end

      expect(page).to have_content("Follower")
      within(first(".follower")) do
        expect(page).to have_css(".login")
      end

      expect(page).to have_content("Following")
      within(first(".user")) do
        expect(page).to have_css(".login")
      end
    end
  end
end
