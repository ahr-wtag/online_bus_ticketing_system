class Seat < ApplicationRecord
  belongs_to :bus, optional: true
  belongs_to :ticket, optional: true
  belongs_to :trip, optional: true

  validates :number, presence: true
end
