class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def increment_counter
    user.update(posts_counter: (user.posts_counter || 0) + 1)
  end

  def recent_comments(count: 5)
    Comment.where(post_id: id).order(created_at: :desc)[0, count]
  end
end
