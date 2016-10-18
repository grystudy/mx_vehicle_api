class MxVehicle::API < Grape::API
	version 'v1', using: :path
	format :json
	prefix :api
	mount UserVehicles
end