require 'rails_helper'

RSpec.describe "As a non-activated user" do
  describe "When I check my email for the registration email" do
    describe "I should see a link that says 'Visit here to activate your account.' and click" do
      it "I should see a message 'Thank you! Your account is now activated.' and /dashboard should say 'Status: Active' " do
        email = 'manilda7@gmail.com'
        first_name = 'Andrew'
        last_name = 'J'
        password = 'password'
        password_confirmation = 'password'

        visit '/'
        click_on 'Register'
        expect(current_path).to eq('/register')


        fill_in 'user[email]', with: email
        fill_in 'user[first_name]', with: first_name
        fill_in 'user[last_name]', with: last_name
        fill_in 'user[password]', with: password
        fill_in 'user[password_confirmation]', with: password

        click_on 'Create Account'
        user = User.last
        expect(current_path).to eq('/dashboard')
        expect(page).to have_content("Logged in as #{user.first_name}")
        expect(page).to have_content("This account has not yet been activated. Please check your email.")

        page.driver.submit :patch, activation_path(user.id), {}

        # visit activation_path(user.id)
        expect(current_path).to eq(activation_path(user.id))
        user.reload
        expect(page).to have_content("Thank you! Your account is now activated!")

        visit dashboard_path
        expect(page).to have_content("Status: Active")
      end
    end
  end
end

# As a non-activated user
# When I check my email for the registration email

# EMAIL PART
# I should see a message that says "Visit here to activate your account."
# And when I click on that link
# Then I should be taken to a page that says "Thank you! Your account is now activated."
#
# And when I visit "/dashboard"
# Then I should see "Status: Active"
