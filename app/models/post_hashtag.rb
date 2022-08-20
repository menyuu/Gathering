# == Schema Information
#
# Table name: post_hashtags
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hashtag_id :integer          not null
#  post_id    :integer          not null
#
# Indexes
#
#  index_post_hashtags_on_hashtag_id  (hashtag_id)
#  index_post_hashtags_on_post_id     (post_id)
#
# Foreign Keys
#
#  hashtag_id  (hashtag_id => hashtags.id)
#  post_id     (post_id => posts.id)
#
class PostHashtag < ApplicationRecord
  belongs_to :post
  belongs_to :hashtag

  with_options presence: true do
    validates :post_id
    validates :hashtag_id
  end
end
