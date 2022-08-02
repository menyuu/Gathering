# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  status     :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Game < ApplicationRecord
  has_many :end_user_games, dependent: :destroy
  has_many :users, through: :end_user_games, source: :end_user
  has_many :group_games
  has_many :groups, through: :group_games

  def self.search_for(word)
    games = []
    perfect_match_games = Game.where(name: word).order(created_at: :DESC)
    backward_match_games = Game.where("name LIKE ?", "#{word}%").order(created_at: :DESC)
    prefix_match_games = Game.where("name LIKE ?", "%#{word}").order(created_at: :DESC)
    partial_match_games = Game.where("name LIKE ?", "%#{word}%").order(created_at: :DESC)
    games.push(perfect_match_games, backward_match_games, prefix_match_games, partial_match_games)
    games.flatten!
    return unique_games = games.uniq { |game| game.id }
  end
end
