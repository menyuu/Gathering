class GroupChat < ApplicationRecord
  belongs_to :end_user
  belongs_to :group
end
