Dir["#{Rails.root}/app/api/entities/*.rb"].each { |file| require file }
require "defaults.rb"
module API
  class UserVehicles < Grape::API
    include Defaults
    namespace :vehicle do
      desc "获取用户的车辆列表" do
        failure [{code: 200, message: 'OK'},
                 {code: 400, message: "参数不合法"},
                 {code: 404, message: "url错误"},
                 {code: 500, message: "其他未知错误"}]
      end
      params do
        requires :user, type: Integer, desc: '用户Id'
      end
      get do
        vehicles = UserVehicle.where(user: params[:user]).all
        present :all, vehicles, with: Entities::Vehicle
      end

      desc '创建车辆' do
        failure [{code: 201, message: 'OK'},
                 {code: 400, message: "参数不合法"},
                 {code: 404, message: "url错误"},
                 {code: 500, message: "其他未知错误"}]
        params Entities::Vehicle.documentation.except(:id)
      end
      post do
        new_ = UserVehicle.create params
        present id: new_.id
      end

      desc '更新车辆' do
        failure [{code: 200, message: 'OK'},
                 {code: 400, message: "参数不合法"},
                 {code: 404, message: "找不到该条数据"},
                 {code: 500, message: "其他未知错误"}]
        params ::API::Entities::Vehicle.documentation.except(:user)
      end
      put do
        item_ = UserVehicle.find(params[:id])
        item_.update params
      end

      desc '删除车辆' do
        failure [{code: 200, message: 'OK'},
                 {code: 400, message: "参数不合法"},
                 {code: 404, message: "找不到该条数据"},
                 {code: 500, message: "其他未知错误"}]
        params ::API::Entities::Vehicle.documentation.except(:user)
      end
      params do
        requires :id, type: Integer, desc: '车辆Id', documentation: {example: '1'}
      end
      delete do
        UserVehicle.destroy(params[:id])
      end
    end
  end
end