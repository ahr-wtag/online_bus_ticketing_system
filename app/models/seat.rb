class Seat < ApplicationRecord
  belongs_to :bus
  belongs_to :ticket, optional: true
  validates :number, presence: true
end
