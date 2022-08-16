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
  belongs_to :user, class_name: "EndUser", foreign_key: :end_user_id
  belongs_to :game

  with_options presence: true do
    validates :end_user_id, uniqueness: { scope: [:game_id] }
    validates :game_id
  end
  validate :tags_limit_count

  LIMIT_COUNT = 8

  def tags_limit_count
    if user.tags.size >= LIMIT_COUNT
      return
    end
  end
end
