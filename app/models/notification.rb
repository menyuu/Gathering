# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  action     :string
#  checked    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comment_id :integer
#  post_id    :integer
#  visited_id :integer
#  visiter_id :integer
#
class Notification < ApplicationRecord
  belongs_to :visiter, class_name: "EndUser", foreign_key: "visiter_id", optional: true
  belongs_to :visited, class_name: "EndUser", foreign_key: "visited_id", optional: true
  belongs_to :post, optional: true
  belongs_to :comment, class_name: "PostComment", optional: true

  # 表示順のデフォルトを降順
  default_scope -> { order(created_at: :desc) }
end
