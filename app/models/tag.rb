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

  enum status: { prepared: 0, self_made: 1, hide: 2 }

  with_options presence: true do
    validates :name, uniqueness: true, length: { maximum: 50 }
    validates :status, inclusion: { in: Tag.statuses.keys }
  end

  # 検索用
  def self.search_for(word)
    Tag.find_by(name: word)
  end
end
