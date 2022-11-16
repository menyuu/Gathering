# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Room < ApplicationRecord
  has_many :end_user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  
end
