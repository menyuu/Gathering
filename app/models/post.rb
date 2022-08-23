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
  attr_accessor :name
  accepts_nested_attributes_for :post_tags
  accepts_nested_attributes_for :tags
  has_many_attached :images

  enum status: { published: 0, draft: 1 }

  IMAGE_LIMITED = 4

  with_options presence: true do
    validates :text, length: { maximum: 200 }
    validates :status, inclusion: { in: Post.statuses.keys }
  end
  validate :images_length

  before_create -> { self.id = SecureRandom.random_number(10000000) }

  # 投稿にcurrent_end_userのいいねがあるかどうかを判定
  def favorited_by?(user)
    favorites.exists?(end_user_id: user.id)
  end

  # 完全一致、後方、前方、部分、に当てはまる投稿を配列に直し重複しているものを除外
  def self.search_for(word)
    # 公開されているユーザーを取得
    published_user = EndUser.where(status: "published")
    posts = []
    perfect_match_posts = Post.where(text: word, end_user_id: published_user, status: "published").with_attached_images.includes(:post_tags, :tags, user: [icon_attachment: [:blob]]).order(created_at: :DESC)
    backward_match_posts = Post.where("text LIKE ?", "#{word}%").where(end_user_id: published_user, status: "published").with_attached_images.includes(:post_tags, :tags, user: [icon_attachment: [:blob]]).order(created_at: :DESC)
    prefix_match_posts = Post.where("text LIKE ?", "%#{word}").where(end_user_id: published_user, status: "published").with_attached_images.includes(:post_tags, :tags, user: [icon_attachment: [:blob]]).order(created_at: :DESC)
    partial_match_posts = Post.where("text LIKE ?", "%#{word}%").where(end_user_id: published_user, status: "published").with_attached_images.includes(:post_tags, :tags, user: [icon_attachment: [:blob]]).order(created_at: :DESC)
    posts.push(perfect_match_posts, backward_match_posts, prefix_match_posts, partial_match_posts)
    # 一次元配列にする
    posts.flatten!
    # 重複したデータを取り除く
    unique_posts = posts.uniq { |post| post.id }
    return unique_posts
  end

  private

  def images_length
    if images.length > IMAGE_LIMITED
      errors.add(:images, "の投稿可能な数は4枚までです。")
    end
  end
end
