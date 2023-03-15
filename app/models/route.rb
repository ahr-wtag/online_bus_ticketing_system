class Route < ApplicationRecord
    has_many :trips
    validates :origin, :destination, presence: true
end
