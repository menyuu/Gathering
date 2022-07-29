# == Schema Information
#
# Table name: end_users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  introduction           :text             default(""), not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status                 :integer          default(0), not null
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

  has_many :end_user_tags
  has_many :tags, through: :end_user_tags
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :end_user_games
  has_many :games, through: :end_user_games
  has_many :end_user_genres
  has_many :genres, through: :end_user_genres
  has_many :user_groups, class_name: "EndUserGroup", dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :group_chats, dependent: :destroy

  enum status: { published: 0, limited: "限定公開", privately: "非公開" }

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

end
