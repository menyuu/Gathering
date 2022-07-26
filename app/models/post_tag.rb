# == Schema Information
#
# Table name: post_tags
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  post_id        :integer          not null
#  posting_tag_id :integer          not null
#
# Indexes
#
#  index_post_tags_on_post_id         (post_id)
#  index_post_tags_on_posting_tag_id  (posting_tag_id)
#
# Foreign Keys
#
#  post_id         (post_id => posts.id)
#  posting_tag_id  (posting_tag_id => posting_tags.id)
#
class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :posting_tag
end
