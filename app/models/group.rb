# == Schema Information
#
# Table name: groups
#
#  id           :integer          not null, primary key
#  introduction :text             not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  owner_id     :integer          not null
#
# Indexes
#
#  index_groups_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  owner_id  (owner_id => end_users.id)
#
class Group < ApplicationRecord
  belongs_to :owner, class_name: "EndUser"
  has_many :user_groups, class_name: "EndUserGroup", dependent: :destroy
  has_many :users, through: :user_groups, source: :user
  has_many :group_chats, dependent: :destroy
  has_many :chat_users, through: :group_chats, source: :user
  has_many :group_tags, dependent: :destroy
  has_many :tags, through: :group_tags
  has_many :group_genres, dependent: :destroy
  has_many :genres, through: :group_genres
  has_many :group_games, dependent: :destroy
  has_many :games, through: :group_games

  has_one_attached :icon

  before_create -> { self.id = SecureRandom.random_number(1000000000) }

  def group_icon(width, height)
    unless icon.attached?
      file_path = Rails.root.join('app/assets/images/group_no_image.png')
      icon.attach(io: File.open(file_path), filename: 'group-default-image.png', content_type: 'image/png')
    end
    icon.variant(gravity: "center", resize: "#{width}x#{height}^", crop: "#{width}x#{height}+0+0")
  end

  def is_ownerd_by?(user)
    owner.id == user.id
  end

  def includesUser?(user)
    user_groups.exists?(end_user_id: user.id)
  end

  def sameHasTag?(user)
    tags.any? { |i| user.tags.include?(i) }
  end

  def sameHasGenre?(user)
    genres.any? { |i| user.genres.include?(i) }
  end

  def sameHasGame?(user)
    games.any? { |i| user.games.include?(i) }
  end

  def self.search_for(object, word, user_id)
    case object
    when "group_id"
      if Group.exists?(word)
        specific_user = []
        user = Group.where(id: user_id)
        specific_user << user
        return user
      else
        return self.all
      end
    when "group"
      users = []
      perfect_match_users = Group.where(name: word)
      backward_match_users = Group.where("name LIKE ?", "#{word}%")
      prefix_match_users = Group.where("name LIKE ?", "%#{word}")
      partial_match_users = Group.where("name LIKE ?", "%#{word}%")
      users.push(perfect_match_users, backward_match_users, prefix_match_users, partial_match_users)
      users.flatten!
      return unique_users = users.uniq { |user| user.id }
    when "group_keyword"
      users = []
      perfect_match_users = Group.where(name: word)
      backward_match_users = Group.where("name LIKE ?", "#{word}%")
      prefix_match_users = Group.where("name LIKE ?", "%#{word}")
      partial_match_users = Group.where("name LIKE ?", "%#{word}%")
      perfect_match_users_introduction = Group.where(introduction: word)
      backward_match_users_introduction = Group.where("introduction LIKE ?", "#{word}%")
      prefix_match_users_introduction = Group.where("introduction LIKE ?", "%#{word}")
      partial_match_users_introduction = Group.where("introduction LIKE ?", "%#{word}%")
      users.push(perfect_match_users, backward_match_users, prefix_match_users, partial_match_users,
      perfect_match_users_introduction, backward_match_users_introduction, prefix_match_users_introduction, partial_match_users_introduction)
      users.flatten!
      return unique_users = users.uniq { |user| user.id }
    end
  end
end
