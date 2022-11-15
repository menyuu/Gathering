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
require "test_helper"

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
