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
  has_many :end_user_groups, dependent: :destroy
  has_many :users, through: :end_user_groups, source: :user
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
end
