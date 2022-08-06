# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  status     :integer          default("self_made"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Game < ApplicationRecord
  has_many :end_user_games, dependent: :destroy
  has_many :users, through: :end_user_games, source: :user
  has_many :group_games, dependent: :destroy
  has_many :groups, through: :group_games

  enum status: { prepared: 0, self_made: 1 }

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

  def self.create_game(game_name, create_game_model)
    games = game_name.split(",")
    games.each do |game|
      game = self.find_or_create_by(name: game)
      create_game_model.games.delete(game)
      create_game_model.games << game
    end
  end

  def self.update_game(game_name, add_game_model)
    game = self.find_by(name: game_name)
    add_game_model.games.delete(game)
    add_game_model.games << game
  end

  def self.destroy_game(game_name, remove_game_model)
    game = self.find_by(name: game_name)
    if remove_game_model.games.size > 1
      remove_game_model.games.delete(game)
    end
  end
end
