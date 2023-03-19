class Route < ApplicationRecord
    has_many :trips
    validates :origin, :destination, presence: true
    attr_accessor :fullRoute
    after_initialize :getFullRoute

    def getFullRoute
       self.fullRoute = (self.origin.to_s)+"-"+(self.destination.to_s)
    end

end
