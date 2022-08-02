# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  status     :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Genre < ApplicationRecord
  has_many :end_user_genres
  has_many :users, through: :end_user_genres, source: :end_user
  has_many :group_genres
  has_many :groups, through: :group_genres

  def self.search_for(word)
    genres = []
    perfect_match_genres = Genre.where(name: word).order(created_at: :DESC)
    backward_match_genres = Genre.where("name LIKE ?", "#{word}%").order(created_at: :DESC)
    prefix_match_genres = Genre.where("name LIKE ?", "%#{word}").order(created_at: :DESC)
    partial_match_genres = Genre.where("name LIKE ?", "%#{word}%").order(created_at: :DESC)
    genres.push(perfect_match_genres, backward_match_genres, prefix_match_genres, partial_match_genres)
    genres.flatten!
    return unique_genres = genres.uniq { |genre| genre.id }
  end
end
