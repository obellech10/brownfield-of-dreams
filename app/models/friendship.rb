class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_create :create_inverse, unless: :has_inverse?

  def create_inverse
    self.class.create(inverse_match_options)
  end

  def has_inverse?
    self.class.exists?(inverse_match_options)
  end

  def inverse_match_options
    { friend_id: user_id, user_id: friend_id }
  end
end
