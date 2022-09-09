# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  message    :text             not null
#  name       :string           not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Contact < ApplicationRecord
end
