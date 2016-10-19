require "grape-swagger"
class MxVehicle::API < Grape::API
	version 'v1', using: :path
	format :json
	prefix :api
	mount UserVehicles
	add_swagger_documentation(
			:api_version => "v1",
			hide_documentation_path: true,
			hide_format: true
	)
end
