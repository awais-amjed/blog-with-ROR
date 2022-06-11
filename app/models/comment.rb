class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def increment_counter
    post.update(comments_counter: (post.comments_counter || 0) + 1)
  end
end
