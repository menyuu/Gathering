# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_many :end_user_tags, dependent: :destroy
  has_many :users, through: :end_user_tags, source: :end_user
  has_many :group_tags, dependent: :destroy
  has_many :groups, through: :group_tags
end
