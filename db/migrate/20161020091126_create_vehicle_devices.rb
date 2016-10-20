class CreateVehicleDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_devices do |t|
      t.integer :vehicle
      t.string :device
      t.integer :status
      t.time :lw
      t.time :lp

      t.timestamps
    end
  end
end
