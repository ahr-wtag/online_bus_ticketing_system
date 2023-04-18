class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :payment
  belongs_to :trip, optional: true
  has_many :seats, dependent: :nullify
  belongs_to :bus, optional: true
  validates :total_fare, presence: true

  def total_price
    if seats&.count && trip&.ticket_price
      seats&.count&.* trip&.ticket_price
    else
      'N/A'
    end
  end
end
