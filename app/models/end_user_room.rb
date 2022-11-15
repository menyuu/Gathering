# == Schema Information
#
# Table name: end_user_rooms
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  end_user_id :integer          not null
#  room_id     :integer          not null
#
# Indexes
#
#  index_end_user_rooms_on_end_user_id  (end_user_id)
#  index_end_user_rooms_on_room_id      (room_id)
#
# Foreign Keys
#
#  end_user_id  (end_user_id => end_users.id)
#  room_id      (room_id => rooms.id)
#
class EndUserRoom < ApplicationRecord
  belongs_to :end_user
  belongs_to :room
end
