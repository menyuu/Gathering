# == Schema Information
#
# Table name: chats
#
#  id          :integer          not null, primary key
#  message     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  end_user_id :integer          not null
#  room_id     :integer          not null
#
# Indexes
#
#  index_chats_on_end_user_id  (end_user_id)
#  index_chats_on_room_id      (room_id)
#
# Foreign Keys
#
#  end_user_id  (end_user_id => end_users.id)
#  room_id      (room_id => rooms.id)
#
require "test_helper"

class ChatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
