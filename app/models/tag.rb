# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  status     :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_many :end_user_tags, dependent: :destroy
  has_many :users, through: :end_user_tags, source: :end_user
  has_many :group_tags, dependent: :destroy
  has_many :groups, through: :group_tags

  def self.search_for(word)
    tags = []
    perfect_match_tags = Tag.where(name: word).order(created_at: :DESC)
    backward_match_tags = Tag.where("name LIKE ?", "#{word}%").order(created_at: :DESC)
    prefix_match_tags = Tag.where("name LIKE ?", "%#{word}").order(created_at: :DESC)
    partial_match_tags = Tag.where("name LIKE ?", "%#{word}%").order(created_at: :DESC)
    tags.push(perfect_match_tags, backward_match_tags, prefix_match_tags, partial_match_tags)
    tags.flatten!
    return unique_tags = tags.uniq { |tag| tag.id }
  end
end
