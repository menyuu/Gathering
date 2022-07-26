# == Schema Information
#
# Table name: end_user_games
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  end_user_id :integer          not null
#  game_id     :integer          not null
#
# Indexes
#
#  index_end_user_games_on_end_user_id  (end_user_id)
#  index_end_user_games_on_game_id      (game_id)
#
# Foreign Keys
#
#  end_user_id  (end_user_id => end_users.id)
#  game_id      (game_id => games.id)
#
class EndUserGame < ApplicationRecord
  belongs_to :end_user
  belongs_to :game
end
