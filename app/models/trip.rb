class Trip < ApplicationRecord
  validates :start_address, :destination_address, presence: true

  before_save :add_price

  def add_price
    self.price = 1.1 * self.distance
  end
end
