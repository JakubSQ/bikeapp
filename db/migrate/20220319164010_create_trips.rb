# frozen_string_literal: true

class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string :start_address
      t.string :destination_address
      t.decimal :price, precision: 8, scale: 2
      t.timestamps
    end
  end
end
