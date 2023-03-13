class Route < ApplicationRecord
    validates :origin, :destination, presence: true
end
