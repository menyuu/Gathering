# == Schema Information
#
# Table name: favorites
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  end_user_id :integer          not null
#  post_id     :integer          not null
#
# Indexes
#
#  index_favorites_on_end_user_id  (end_user_id)
#  index_favorites_on_post_id      (post_id)
#
# Foreign Keys
#
#  end_user_id  (end_user_id => end_users.id)
#  post_id      (post_id => posts.id)
#
class Favorite < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
end
