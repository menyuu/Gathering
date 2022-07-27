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
  has_many :user_tags, class_name: "EndUserTag"
  has_many :users, through: :user_tags, source: :end_user
end
