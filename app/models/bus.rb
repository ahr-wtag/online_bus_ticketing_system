class Bus < ApplicationRecord
    validates :name, :type, :brand, :capacity, presence: true
end
