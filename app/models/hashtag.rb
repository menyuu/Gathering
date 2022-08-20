# == Schema Information
#
# Table name: hashtags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_hashtags_on_name  (name) UNIQUE
#
class Hashtag < ApplicationRecord
  has_many :post_hashtags, dependent: :destroy
  has_many :posts, through: :post_hashtags

  validates :name, presence: true, length: { maximum: 50 }
end
