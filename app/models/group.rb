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

  has_one_attached :icon

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
end
