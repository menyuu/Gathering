# == Schema Information
#
# Table name: hashtags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_hashtags_on_name  (name) UNIQUE
#
require "test_helper"

class HashtagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
