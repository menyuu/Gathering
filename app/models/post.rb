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
  belongs_to :end_user
  has_many_attached :images

  
end
