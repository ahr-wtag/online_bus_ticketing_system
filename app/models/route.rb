class Route < ApplicationRecord
  validates :origin, :destination, presence: true, format: { with: /\A[A-Za-z]+\z/ }
end
