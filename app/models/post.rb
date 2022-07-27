# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  text        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  end_user_id :integer          not null
#
# Indexes
#
#  index_posts_on_end_user_id  (end_user_id)
#
# Foreign Keys
#
#  end_user_id  (end_user_id => end_users.id)
#
class Post < ApplicationRecord
  belongs_to :user, class_name: "EndUser", foreign_key: :end_user_id
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many_attached :images

  def favorited_by?(user)
    favorites.exists?(end_user_id: user.id)
  end
end
