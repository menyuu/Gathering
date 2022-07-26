# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_relationships_on_followed_id  (followed_id)
#  index_relationships_on_follower_id  (follower_id)
#
# Foreign Keys
#
#  followed_id  (followed_id => end_users.id)
#  follower_id  (follower_id => end_users.id)
#
class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "EndUser"
  belongs_to :followed, class_name: "EndUser"

  with_options presence: true do
    validates :follower_id, uniqueness: { scope: [:followed_id] }
    validates :followed_id
  end
end
