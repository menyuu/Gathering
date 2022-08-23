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

  validates :name, presence: true, length: { maximum: 30 }
  validates :introduction, length: { maximum: 240 }

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

  # ユーザーがグループと同じタグを所持しているかどうかを判定
  def sameHasItems?(user)
    # 1つでも合致したらグループに参加できるようにする
    # ユーザーのタグ類とグループのタグ類を照らし合わせ1つでも合致したらtrueを
    tags.any? { |i| user.tags.includes(:tags).include?(i) } ||
    genres.any? { |i| user.genres.includes(:genres).include?(i) } ||
    games.any? { |i| user.games.includes(:games).include?(i) }
  end

  # グループ検索用(application_recordに記載)
  def self.search_for(object, word, group_id)
    case object
    when "group_id"
      Group.search_id_match(word, group_id)
    when "group"
      Group.search_match(word, nil)
    when "group_keyword"
      Group.search_keyword_match(word, nil)
    end
  end
end
