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
  has_many :end_user_genres, dependent: :destroy
  has_many :users, through: :end_user_genres, source: :user
  has_many :group_genres, dependent: :destroy
  has_many :groups, through: :group_genres

  enum status: { prepared: 0, self_made: 1 }

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
  
  def self.create_genre(genre_name, create_genre_model)
    genres = genre_name.split(",")
    genres.each do |genre|
      genre = self.find_or_create_by(name: genre)
      create_genre_model.genres.delete(genre)
      create_genre_model.genres << genre
    end
  end

  def self.update_genre(genre_name, add_genre_model)
    genre = self.find_by(name: genre_name)
    add_genre_model.genres.delete(genre)
    add_genre_model.genres << genre
  end

  def self.destroy_genre(genre_name, remove_genre_model)
    genre = self.find_by(name: genre_name)
    if remove_genre_model.genres.size > 1
      remove_genre_model.genres.delete(genre)
    end
  end
end
