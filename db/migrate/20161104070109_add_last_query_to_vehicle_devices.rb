class AddLastQueryToVehicleDevices < ActiveRecord::Migration[5.0]
  def change
    remove_column :vehicle_devices, :status, :integer
    remove_column :vehicle_devices, :lw, :time
    remove_column :vehicle_devices, :lp, :time
    add_column :vehicle_devices, :lq, :datetime
    add_column :vehicle_devices, :lw, :datetime
    add_column :vehicle_devices, :lp, :datetime
  end
end
