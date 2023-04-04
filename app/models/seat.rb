class Seat < ApplicationRecord
  belongs_to :bus , optional: true
  has_one :ticket
  
  validates :number, presence: true
end
