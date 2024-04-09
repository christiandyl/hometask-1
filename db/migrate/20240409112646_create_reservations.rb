class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.string :provider
      t.datetime :status
      t.datetime :check_in
      t.datetime :check_out
      t.float :price
      t.string :guest_name
      t.string :listing_id
      t.timestamps
    end
  end
end
