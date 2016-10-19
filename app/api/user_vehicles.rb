
Dir["#{Rails.root}/app/api/entities/*.rb"].each {|file| require file}
module API
  class UserVehicles < Grape::API
    params do
      requires :user, type: Integer, desc: '用户Id'
    end
    namespace :vehicle do
      desc "获取用户的车辆列表"
      get do
        [{sb: 250}]
      end

      desc '创建车辆' do
        http_codes [{code: 201, message: '成功', model: API::Entities::Base},
                    {code: 400, message: '参数错误', model: API::Entities::ApiError}]
      end
      params do
        requires :plate, type: String, desc: '车牌号'
        optional :frame, type: String, desc: '车架号'
        optional :engine, type: String, desc: '发动机号'
        optional :type, type: Integer, default: 2, values: [1, 2], desc: '车辆类型'
      end
      post do
        {'declared_params' => declared(params)}
      end
    end
  end
end