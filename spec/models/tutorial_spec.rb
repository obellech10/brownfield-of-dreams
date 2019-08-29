require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'class methods' do
    it 'Should only return non classroom tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = Tutorial.create!(title: "test", description: 'test', thumbnail: 'test',classroom: true)
      tutorial3 = create(:tutorial)

      expect(Tutorial.non_classroom_tutorials.first).to eq(tutorial1)
    end
  end

  describe 'Validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :description}
    it {should validate_presence_of :thumbnail}
  end
end
