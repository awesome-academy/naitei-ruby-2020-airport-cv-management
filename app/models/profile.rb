class Profile < ApplicationRecord
  belongs_to :gender
  belongs_to :user
end
