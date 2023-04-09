class Trip < ApplicationRecord
  belongs_to :bus
  belongs_to :route
  has_many :tickets
  validates :ticket_price, :total_booked, :date, :time, presence: true
  validate :check_if_present

  def check_if_present
    if new_record?
      if Trip.where(date:self.date,time:self.time,bus:self.bus).size >=1
        errors.add(:time, "Trip is already exist with tihs bus on this date and time");
      end
    end
  end
  def time=(time)
    super(time.to_datetime.strftime("%I:%M %P"))
end
end
