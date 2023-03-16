class Bus < ApplicationRecord
    has_many :tickets
    has_many :seats, dependent: :delete_all
    has_one :trip
    validates :name, uniqueness: { case_sensitive: false }
    validates :name, :typed, :brand, :capacity, presence: true

    validates :capacity , numericality: { greater_than:0, less_than_or_equal_to: 45 }

    TYPES = ['ac','non-ac']
    validates_inclusion_of :typed, in: TYPES
    accepts_nested_attributes_for :seats

    def typed=(typed)
        super(typed.downcase.strip)
    end

    def name=(name)
        super(name.downcase.strip.delete(' '))
    end

    def brand=(brand)
        super(brand.upcase.strip)
    end

end
