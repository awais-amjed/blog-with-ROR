class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_counter

  def update_counter
    user.update(posts_counter: user.posts.count)
  end

  def recent_comments(count: 5)
    comments.order(created_at: :desc)[0, count]
  end
end
