class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'author_id', inverse_of: :author, dependent: :destroy
  has_many :likes, foreign_key: 'author_id', inverse_of: :author, dependent: :destroy
  has_many :comments, foreign_key: 'author_id', inverse_of: :author, dependent: :destroy

  # For the User model:Name must not be blank.
  validates :name, presence: true
  # PostsCounter must be an integer greater than or equal to zero.
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order(created_at: :asc).limit(3)
  end

  ROLES = %i[admin user].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end
end
