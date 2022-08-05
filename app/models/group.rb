# == Schema Information
#
# Table name: groups
#
#  id           :integer          not null, primary key
#  introduction :text             default(""), not null
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
    icon.variant(gravity: "center", resize: "#{width}x#{height}^", crop: "#{width}x#{height}+0+0").processed
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

  def self.search_for(word)
    groups = []
    perfect_match_groups = Group.where(name: word)
    backward_match_groups = Group.where("name LIKE ?", "#{word}%")
    prefix_match_groups = Group.where("name LIKE ?", "%#{word}")
    partial_match_groups = Group.where("name LIKE ?", "%#{word}%")
    groups.push(perfect_match_groups, backward_match_groups, prefix_match_groups, partial_match_groups)
    groups.flatten!
    return unique_groups = groups.uniq { |group| group.id }
  end
end
