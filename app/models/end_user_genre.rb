# == Schema Information
#
# Table name: end_user_genres
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  end_user_id :integer          not null
#  genre_id    :integer          not null
#
# Indexes
#
#  index_end_user_genres_on_end_user_id  (end_user_id)
#  index_end_user_genres_on_genre_id     (genre_id)
#
# Foreign Keys
#
#  end_user_id  (end_user_id => end_users.id)
#  genre_id     (genre_id => genres.id)
#
class EndUserGenre < ApplicationRecord
  belongs_to :end_user
  belongs_to :genre
end
