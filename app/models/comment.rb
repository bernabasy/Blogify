class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_counter
  before_destroy :decrease_counter

  private

  def update_counter
    post.increment!(:comments_counter)
  end

  def decrease_counter
    post.decrement!(:comments_counter)
  end
end
