# == Schema Information
#
# Table name: group_chats
#
#  id          :integer          not null, primary key
#  text        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  end_user_id :integer          not null
#  group_id    :integer          not null
#
# Indexes
#
#  index_group_chats_on_end_user_id  (end_user_id)
#  index_group_chats_on_group_id     (group_id)
#
# Foreign Keys
#
#  end_user_id  (end_user_id => end_users.id)
#  group_id     (group_id => groups.id)
#
class GroupChat < ApplicationRecord
  belongs_to :user, class_name: "EndUser", foreign_key: :end_user_id
  belongs_to :group

  with_options presence: true do
    validates :end_user_id, uniqueness: { scope: [:group_id] }
    validates :group_id
  end
  validates :text, presence: true, length: { maximum: 400 }
end
