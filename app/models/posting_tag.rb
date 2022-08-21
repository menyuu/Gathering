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

  with_options presence: true do
    validates :name, uniqueness: true, length: { maximum: 50 }
  end

end
