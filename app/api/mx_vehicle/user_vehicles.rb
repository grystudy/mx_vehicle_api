class MxVehicle::UserVehicles < Grape::API
  params do
    requires :user_id, type: Integer, desc: 'user ID.'
  end
  namespace :UserVehicle do
    desc "Get all vehicles of this user."
    get 'all' do
      [{sb: 250}]
    end

    desc 'Create a vehicle.'
    params do
      requires :chepai, type: String, desc: 'Plate number of the car.'
    end
    post 'Create' do
      {'declared_params' => declared(params)}
    end
  end
end