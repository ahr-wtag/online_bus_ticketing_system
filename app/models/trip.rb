class Trip < ApplicationRecord
  belongs_to :bus
  belongs_to :route
  has_many :tickets
  validates :ticket_price, :total_booked, :date, :time, presence: true
end
