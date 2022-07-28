# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Game < ApplicationRecord
  has_many :end_user_games, dependent: :destroy
  has_many :users, through: :end_user_games, source: :end_user
  has_many :group_games
  has_many :groups, through: :group_games
end
