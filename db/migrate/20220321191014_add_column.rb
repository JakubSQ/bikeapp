class AddColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :distance, :integer
  end
end
