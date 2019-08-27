require 'rails_helper'

RSpec.describe 'As a logged in user' do
  describe 'I can add see my github followers' do
    before :each do
      json_response = File.open("./fixtures/github_following.json")
      stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: json_response)
    end

    it 'and add them as friends if they are registered users' do
      user_1 = User.create!(first_name: 'Andrew',
                             last_name: 'Johnson',
                              password: 'test',
                          github_token: 'test1',
                       github_nickname: 'Loomus',
                                 email: 'manilda7@gmail.com')

      user_2 = User.create!(first_name: 'Martha',
                             last_name: 'Troubh',
                              password: 'test',
                          github_token: 'test2',
                       github_nickname: 'Martsy',
                                 email: 'martha@example.com')

      user_3 = User.create!(first_name: 'Shiela',
                             last_name: 'Mariano',
                              password: 'test',
                                 email: 'sherocks@example.com')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit dashboard_path

      expect(page).to have_content("Github")
      expect(page).to have_content("Following")

      within(first(".user")) do
        expect(page).to have_button("Add Friend")
        click_button 'Add Friend'
      end

      user_1.reload
      visit dashboard_path

      within(first(".user")) do
        expect(page).to_not have_button("Add Friend")
      end

      within(page.all(".user")[1]) do
        expect(page).to_not have_button("Add Friend")
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Friends")

      within(first(".friends")) do
        expect(page).to have_css(".github_nickname")
        expect(page).to have_content(user_2.github_nickname)
      end

      expect(user_2.friends.first.github_nickname).to eq(user_1.github_nickname)
    end
  end
end
