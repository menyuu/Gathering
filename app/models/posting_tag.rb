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
    PostingTag.find_by(name: word)
  end
end
