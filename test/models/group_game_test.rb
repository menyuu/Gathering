# == Schema Information
#
# Table name: group_games
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :integer          not null
#  group_id   :integer          not null
#
# Indexes
#
#  index_group_games_on_game_id   (game_id)
#  index_group_games_on_group_id  (group_id)
#
# Foreign Keys
#
#  game_id   (game_id => games.id)
#  group_id  (group_id => groups.id)
#
require "test_helper"

class GroupGameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
