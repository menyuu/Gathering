# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  status      :integer          default("published"), not null
#  text        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  end_user_id :integer          not null
#
# Indexes
#
#  index_posts_on_end_user_id  (end_user_id)
#
# Foreign Keys
#
#  end_user_id  (end_user_id => end_users.id)
#
class Post < ApplicationRecord
  belongs_to :user, class_name: "EndUser", foreign_key: :end_user_id
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, source: :posting_tag
  has_many_attached :images

  enum status: { published: 0, draft: 1 }

  before_create -> { self.id = SecureRandom.random_number(100000000000000) }

  def favorited_by?(user)
    favorites.exists?(end_user_id: user.id)
  end

  def self.search_for(word)
    posts = []
    perfect_match_posts = Post.where(text: word)
    backward_match_posts = Post.where("text LIKE ?", "#{word}%")
    prefix_match_posts = Post.where("text LIKE ?", "%#{word}")
    partial_match_posts = Post.where("text LIKE ?", "%#{word}%")
    posts.push(perfect_match_posts, backward_match_posts, prefix_match_posts, partial_match_posts)
    posts.flatten!
    return unique_posts = posts.uniq { |post| post.id }
  end
end
