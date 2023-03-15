class Bus < ApplicationRecord
    has_many :tickets
    has_many :seats
    has_one :trip
    
    validates :name, :typed, :brand, :capacity, presence: true
end
