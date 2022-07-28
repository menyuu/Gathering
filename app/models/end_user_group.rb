# == Schema Information
#
# Table name: end_user_groups
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  end_user_id :integer          not null
#  group_id    :integer          not null
#
# Indexes
#
#  index_end_user_groups_on_end_user_id  (end_user_id)
#  index_end_user_groups_on_group_id     (group_id)
#
# Foreign Keys
#
#  end_user_id  (end_user_id => end_users.id)
#  group_id     (group_id => groups.id)
#
class EndUserGroup < ApplicationRecord
  belongs_to :user, class_name: "EndUser", foreign_key: :end_user_id
  belongs_to :group
end
