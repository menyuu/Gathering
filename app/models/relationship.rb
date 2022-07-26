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
#  followed_id  (followed_id => followeds.id)
#  follower_id  (follower_id => followers.id)
#
class Relationship < ApplicationRecord
  belongs_to :follower
  belongs_to :followed
end
