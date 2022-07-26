# == Schema Information
#
# Table name: group_tags
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :integer          not null
#  tag_id     :integer          not null
#
# Indexes
#
#  index_group_tags_on_group_id  (group_id)
#  index_group_tags_on_tag_id    (tag_id)
#
# Foreign Keys
#
#  group_id  (group_id => groups.id)
#  tag_id    (tag_id => tags.id)
#
class GroupTag < ApplicationRecord
  belongs_to :group
  belongs_to :tag
end
