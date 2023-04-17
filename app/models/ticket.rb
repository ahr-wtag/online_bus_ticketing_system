class Ticket < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :payment, optional: true
  belongs_to :trip, optional: true
  has_many :seats, dependent: :destroy
  belongs_to :bus, optional: true
  validates :total_fare, presence: true

  def total_price
    seats.count * trip.ticket_price
  end
end
