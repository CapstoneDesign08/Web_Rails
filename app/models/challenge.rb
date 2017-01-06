class Challenge < ApplicationRecord
  has_many :applicants
  validates :attachment,  :presence => true
end
