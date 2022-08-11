# == Schema Information
#
# Table name: end_users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  introduction           :text
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status                 :integer          default("published"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_end_users_on_email                 (email) UNIQUE
#  index_end_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :end_user_tags, dependent: :destroy
  has_many :tags, through: :end_user_tags, source: :tag
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :end_user_games, dependent: :destroy
  has_many :games, through: :end_user_games
  has_many :end_user_genres, dependent: :destroy
  has_many :genres, through: :end_user_genres
  has_many :user_groups, class_name: "EndUserGroup", dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :group_chats, dependent: :destroy

  has_one_attached :icon

  enum status: { published: 0, privately: 1, freeze: 2 }

  before_create -> { self.id = SecureRandom.random_number(1000000000) }

  def user_icon(width, height)
    unless icon.attached?
      file_path = Rails.root.join('app/assets/images/user_no_image.png')
      icon.attach(io: File.open(file_path), filename: 'user-default-image.png', content_type: 'image/png')
    end
    icon.variant(gravity: "center", resize: "#{width}x#{height}^", crop: "#{width}x#{height}+0+0").processed
  end

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search_for(object, word, user_id)
    case object
    when "id"
      if EndUser.exists?(word)
        specific_user = []
        user = EndUser.where(id: user_id)
        specific_user << user
        specific_user.flatten!
        return specific_user
      else
        return self.all
      end
    when "user"
      users = []
      perfect_match_users = EndUser.where(name: word, status: "published")
      backward_match_users = EndUser.where("name LIKE ?", "#{word}%").where(status: "published")
      prefix_match_users = EndUser.where("name LIKE ?", "%#{word}").where(status: "published")
      partial_match_users = EndUser.where("name LIKE ?", "%#{word}%").where(status: "published")
      users.push(perfect_match_users, backward_match_users, prefix_match_users, partial_match_users)
      users.flatten!
      return unique_users = users.uniq { |user| user.id }
    when "user_keyword"
      users = []
      perfect_match_users = EndUser.where(name: word, status: "published")
      backward_match_users = EndUser.where("name LIKE ?", "#{word}%").where(status: "published")
      prefix_match_users = EndUser.where("name LIKE ?", "%#{word}").where(status: "published")
      partial_match_users = EndUser.where("name LIKE ?", "%#{word}%").where(status: "published")
      perfect_match_users_introduction = EndUser.where(introduction: word, status: "published")
      backward_match_users_introduction = EndUser.where("introduction LIKE ?", "#{word}%").where(status: "published")
      prefix_match_users_introduction = EndUser.where("introduction LIKE ?", "%#{word}").where(status: "published")
      partial_match_users_introduction = EndUser.where("introduction LIKE ?", "%#{word}%").where(status: "published")
      users.push(perfect_match_users, backward_match_users, prefix_match_users, partial_match_users,
      perfect_match_users_introduction, backward_match_users_introduction, prefix_match_users_introduction, partial_match_users_introduction)
      users.flatten!
      return unique_users = users.uniq { |user| user.id }
    end
  end

  # ゲストユーザー作成メソッド
  def self.guest
    self.find_or_create_by!(name: "ゲストユーザー", email: "guest_user@example.com") do |guest|
      guest.password = SecureRandom.urlsafe_base64
      guest.email = "guest_user@example.com"
    end
  end
end
