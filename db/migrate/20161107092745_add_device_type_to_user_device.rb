class AddDeviceTypeToUserDevice < ActiveRecord::Migration[5.0]
  def change
    add_column :user_devices, :dtype, :integer
  end
end
