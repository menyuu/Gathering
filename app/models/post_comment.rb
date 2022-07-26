# == Schema Information
#
# Table name: post_comments
#
#  id          :integer          not null, primary key
#  comment     :text             not null
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
  belongs_to :end_user
  belongs_to :post
end
