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
end
