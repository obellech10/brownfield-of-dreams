require 'rails_helper'

RSpec.describe "Tutorials" do
  describe "As a user, when I visit a tutorials' show page" do
    it "An error occurs when trying to call current_video.title since current_video is nil." do
      tutorial_1 = Tutorial.create!(title: "test", description: 'test', thumbnail: "test", classroom: true)

      visit tutorial_path(tutorial_1.id)

      expect(page).to have_content("This tutorial does not have any videos.")
    end
  end
end
