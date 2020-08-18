class JobPost < ApplicationRecord
  belongs_to :catagory
  belongs_to :user
  belongs_to :unit
end
