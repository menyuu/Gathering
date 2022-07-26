# == Schema Information
#
# Table name: group_genres
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  genre_id   :integer          not null
#  group_id   :integer          not null
#
# Indexes
#
#  index_group_genres_on_genre_id  (genre_id)
#  index_group_genres_on_group_id  (group_id)
#
# Foreign Keys
#
#  genre_id  (genre_id => genres.id)
#  group_id  (group_id => groups.id)
#
class GroupGenre < ApplicationRecord
  belongs_to :group
  belongs_to :genre
end
