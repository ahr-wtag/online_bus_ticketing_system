class Route < ApplicationRecord
  has_many :trips
  validates :origin, :destination, presence: true, format: { with: /\A[A-Za-z]+\z/ }
end
