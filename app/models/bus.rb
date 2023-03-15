class Bus < ApplicationRecord
    validates :name, :typed, :brand, :capacity, presence: true
end
