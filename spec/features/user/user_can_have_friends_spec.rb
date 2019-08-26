require 'rails_helper'

RSpec.describe 'As a logged in user' do
  describe 'I can add see my github followers' do
    before :each do
      json_response = File.open("./fixtures/github_followers.json")
      stub_request(:get, "https://api.github.com/user/repos")
      .to_return(status: 200, body: json_response)
    end

    it 'and add them as friends if they are registered users' do
      user_1 = User.create!(first_name: 'Dan',
                             last_name: 'Mariano',
                              password: 'test',
                          github_token: 'test1',
                       github_nickname: 'obellech10',
                                 email: 'dan@example.com')

      user_2 = User.create!(first_name: 'tay',
                             last_name: 'james',
                              password: 'test',
                          github_token: 'test2',
                       github_nickname: 'tayjames',
                                 email: 'tay@example.com')

      user_3 = User.create!(first_name: 'Shiela',
                             last_name: 'Mariano',
                              password: 'test',
                                 email: 'sherocks@example.com')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit dashboard_path

      expect(page).to have_content("Github")
      expect(page).to have_content("Follower")

      within(first(".follower")) do
        expect(page).to have_button("Add Friend")
        click_button 'Add Friend'
      end

      user_1.reload
      visit dashboard_path

      within(first(".follower")) do
        expect(page).to_not have_button("Add Friend")
      end

      within(page.all(".follower")[1]) do
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
