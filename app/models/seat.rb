class Seat < ApplicationRecord
  belongs_to :bus
  belongs_to :ticket
  
  validates :number, :booked, presence: true
end
