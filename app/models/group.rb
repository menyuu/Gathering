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
#  owner_id  (owner_id => owners.id)
#
class Group < ApplicationRecord
  belongs_to :owner
end
