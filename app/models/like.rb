class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def increment_counter
    current_post = Post.find(post_id)
    current_post.update(likes_counter: (current_post.likes_counter || 0) + 1)
  end
end
