class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :payment
  belongs_to :trip
  has_many :seat
  belongs_to :bus

  validates :total_fare, presence: true
end
