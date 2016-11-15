class CreateUserVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_vehicles do |t|
      t.string :user
      t.string :plate
      t.string :frame
      t.string :engine
      t.integer :vtype

      t.timestamps
    end
  end
end
