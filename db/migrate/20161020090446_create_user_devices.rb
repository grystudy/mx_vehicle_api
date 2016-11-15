class CreateUserDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :user_devices do |t|
      t.string :user
      t.string :device
      t.integer :status

      t.timestamps
    end
  end
end
