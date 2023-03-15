class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :payment
  belongs_to :trip
  has_many :seats
  belongs_to :bus

  validates :total_fare, presence: true

  def total_price
    self.seats.count * self.trip.ticket_price
  end
end
