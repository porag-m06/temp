class Like < ApplicationRecord
  after_create :update_likes_counter
  after_destroy :update_likes_counter

  # associations
  belongs_to :user, inverse_of: :likes
  belongs_to :post, inverse_of: :likes, counter_cache: :likes_counter

  # custom methods
  # update_likes_counter > updates how many likes a post has.
  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
