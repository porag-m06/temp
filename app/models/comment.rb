class Comment < ApplicationRecord
  after_create :update_comments_counter
  after_destroy :update_comments_counter

  # associations
  belongs_to :user, inverse_of: :comments
  belongs_to :post, inverse_of: :comments, counter_cache: :comments_counter

  # custom methods
  # update_comments_counter > updates how many comments a post has.
  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
