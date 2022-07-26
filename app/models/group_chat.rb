# == Schema Information
#
# Table name: group_chats
#
#  id          :integer          not null, primary key
#  chat        :text             not null
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
  belongs_to :end_user
  belongs_to :group
end
