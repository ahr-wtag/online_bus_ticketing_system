class Seat < ApplicationRecord
  belongs_to :bus
  validates :number, presence: true
end
