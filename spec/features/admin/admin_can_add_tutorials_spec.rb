require 'rails_helper'

describe 'An admin user' do
  it 'can add tutorials' do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in 'Title', with: "Testing in Rails"
    fill_in 'Description', with: "How to use capybara"
    fill_in 'Thumbnail', with: "rails.jpg"

    click_on 'Save'

    tutorial = Tutorial.last

    expect(current_path).to eq(tutorial_path(tutorial.id))
    expect(page).to have_content("Successfully created tutorial")
  end

  it "doesn't add the required fields" do
    admin = create(:user, role: 1)
    video = create(:video)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in 'Title', with: "Testing in Rails"
    fill_in 'Description', with: nil
    fill_in 'Thumbnail', with: "rails.jpg"

    click_on 'Save'

    expect(page).to have_content("Missing information, review form and resubmit")
  end
end
