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
class Genre < ApplicationRecord
  has_many :end_user_genres, dependent: :destroy
  has_many :users, through: :end_user_genres, source: :user
  has_many :group_genres, dependent: :destroy
  has_many :groups, through: :group_genres

  enum status: { prepared: 0, self_made: 1, hide: 2 }

  with_options presence: true do
    validates :name, uniqueness: true, length: { maximum: 50 }
    validates :status, inclusion: { in: Genre.statuses.keys }
  end

  def self.create_genre(genre_names, create_genre_model)
    create_genre_model.genres.destroy_all
    genre_names.uniq.map do |genre|
      genre = self.find_or_create_by(name: genre)
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
    remove_genre_model.genres.delete(genre)
  end
end
