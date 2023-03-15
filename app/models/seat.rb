class Seat < ApplicationRecord
  belongs_to :bus
  has_one :ticket
  
  validates :number, :booked, presence: true
end
