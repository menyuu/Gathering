# == Schema Information
#
# Table name: end_user_tags
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  end_user_id :integer          not null
#  tag_id      :integer          not null
#
# Indexes
#
#  index_end_user_tags_on_end_user_id  (end_user_id)
#  index_end_user_tags_on_tag_id       (tag_id)
#
# Foreign Keys
#
#  end_user_id  (end_user_id => end_users.id)
#  tag_id       (tag_id => tags.id)
#
require "test_helper"

class EndUserTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
