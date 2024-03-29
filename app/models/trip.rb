# frozen_string_literal: true

class Trip < ApplicationRecord
  validates :start_address, :destination_address, presence: true

  before_save :add_price

  def add_price
    self.price = 1.1 * distance
  end
end
