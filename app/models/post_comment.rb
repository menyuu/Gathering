# == Schema Information
#
# Table name: post_comments
#
#  id          :integer          not null, primary key
#  text        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  end_user_id :integer          not null
#  post_id     :integer          not null
#
# Indexes
#
#  index_post_comments_on_end_user_id  (end_user_id)
#  index_post_comments_on_post_id      (post_id)
#
# Foreign Keys
#
#  end_user_id  (end_user_id => end_users.id)
#  post_id      (post_id => posts.id)
#
class PostComment < ApplicationRecord
  belongs_to :user, class_name: "EndUser", foreign_key: :end_user_id
  belongs_to :post
  has_many :notifications, class_name: "Notification", foreign_key: :comment_id, dependent: :destroy

  validates :text, presence: true, length: { maximum: 240 }
end
