# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Genre < ApplicationRecord
  has_many :end_user_genres
  has_many :users, through: :end_user_genres, source: :end_user
  has_many :group_genres
  has_many :groups, through: :group_genres
end
