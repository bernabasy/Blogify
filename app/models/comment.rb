class Comment < ApplicationRecord
  belongs_to :author, class_name: 'user'
  belongs_to :post

  after_save :update_counter

  private

  def update_counter
    post.increment!(:comments_counter)
  end
end
