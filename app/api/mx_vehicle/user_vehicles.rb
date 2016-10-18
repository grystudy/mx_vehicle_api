class MxVehicle::UserVehicles < Grape::API
	namespace :UserVehicle do
    desc "Get all vehicles of this user."
    params do
      requires :user_id, type: Integer, desc: 'user ID.'
    end   
    get 'all' do
      [{sb: 250}]
    end
  end
end