# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  status     :integer          default("self_made"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class GenreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
