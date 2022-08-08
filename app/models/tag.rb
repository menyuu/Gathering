# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  status     :integer          default("self_made"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_many :end_user_tags, dependent: :destroy
  has_many :users, through: :end_user_tags, source: :user
  has_many :group_tags, dependent: :destroy
  has_many :groups, through: :group_tags

  enum status: { prepared: 0, self_made: 1 }

  def self.search_for(word)
    Tag.find_by(name: word)
  end

  def self.create_tag(tag_name, create_tag_model)
    tags = tag_name.split(",")
    tags.each do |tag|
      tag = self.find_or_create_by(name: tag)
      create_tag_model.tags.delete(tag)
      create_tag_model.tags << tag
    end
  end

  def self.update_tag(tag_name, add_tag_model)
    tag = self.find_by(name: tag_name)
    add_tag_model.tags.delete(tag)
    add_tag_model.tags << tag
  end

  def self.destroy_tag(tag_name, remove_tag_model)
    tag = self.find_by(name: tag_name)
    if remove_tag_model.tags.size > 1
      remove_tag_model.tags.delete(tag)
    end
  end
end
