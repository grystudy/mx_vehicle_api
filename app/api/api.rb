require "grape-swagger"
Dir["#{Rails.root}/app/api/*.rb"].each {|file| require file}
module API
  class API < Grape::API
    version 'v1', using: :path
    content_type :json, 'application/json;charset=UTF-8'
    default_format :json
    format :json
    prefix :api
    mount UserVehicles
    mount UserDevices
    add_swagger_documentation(
        info: {title: "车辆管理以及违章推送接口",
               description: "杨宇 yangy@meixing.com"},
        :api_version => "v1",
        hide_documentation_path: true,
        hide_format: true
    )
  end
end
