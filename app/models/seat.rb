class Seat < ApplicationRecord
  belongs_to :bus

  validates :number, :booked, presence: true
end
