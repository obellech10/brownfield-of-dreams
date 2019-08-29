require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'class methods' do
    it 'Should only return non classroom tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = Tutorial.create!(title: "test", description: 'test', classroom: true)
      tutorial3 = create(:tutorial)

      expect(Tutorial.non_classroom_tutorials.first).to eq(tutorial1)
    end
  end

  describe 'CRUD' do
    it 'can be delete and a video associated with is deleted' do
      tutorial_1 = Tutorial.create(id: 1)
      video = Video.create(id: 1, tutorial_id: 1)

      tutorial_1.destroy

      expect(tutorial_1.destroyed?).to eq(true)
      expect(Video.where(tutorial_id: tutorial_1.id)).to eq([])
    end
  end
end
