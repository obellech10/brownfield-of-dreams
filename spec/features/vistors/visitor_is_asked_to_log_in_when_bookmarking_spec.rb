require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and is given an error message saying they must be logged in' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'

    expect(current_path).to eq(login_path)
    expect(page).to have_content("User must be logged in to bookmark video")
  end
end
