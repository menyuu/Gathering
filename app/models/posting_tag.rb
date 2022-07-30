# == Schema Information
#
# Table name: posting_tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PostingTag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  def self.search_for(word)
    post_tags = []
    perfect_match_post_tags = PostingTag.where(name: word)
    backward_match_post_tags = PostingTag.where("name LIKE ?", "#{word}%")
    prefix_match_post_tags = PostingTag.where("name LIKE ?", "%#{word}")
    partial_match_post_tags = PostingTag.where("name LIKE ?", "%#{word}%")
    post_tags.push(perfect_match_post_tags, backward_match_post_tags, prefix_match_post_tags, partial_match_post_tags)
    post_tags.flatten!
    return unique_post_tags = post_tags.uniq { |post_tag| post_tag.id }
  end
end
