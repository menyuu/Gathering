# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  message    :text             not null
#  name       :string           not null
#  status     :integer          default("unread"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Contact < ApplicationRecord
  enum status: { unread: 0, read: 1, hold: 2, working: 3, resolved: 4 }

  with_options presence: true do
    validates :name, length: { maximum: 30 }
    validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :message, length: {maximum: 2000 }
    validates :status, inclusion: { in: Contact.statuses.keys }
  end

end
