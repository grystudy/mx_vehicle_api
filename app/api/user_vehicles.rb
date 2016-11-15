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
        requires :user, type: String, desc: '用户Id'
        optional :appkey, type: String, desc: 'appkey'
      end
      get do
        vehicles = UserVehicle.where(user: params[:user]).all
        # present :all, vehicles, with: Entities::Vehicle
        present :all, vehicles
      end

      desc '创建车辆' do
        failure [{code: 201, message: 'OK'},
                 {code: 400, message: "参数不合法"},
                 {code: 404, message: "url错误"},
                 {code: 500, message: "其他未知错误"}]
      end
      params do
        requires :all, except: [:frame, :engine, :vtype], using: API::Entities::Vehicle.documentation.except(:id)
        optional :appkey, type: String, desc: 'appkey'
      end
      post do
        params.delete :appkey
        new_ = UserVehicle.create params
        present id: new_.id
      end

      desc '更新车辆' do
        failure [{code: 200, message: 'OK'},
                 {code: 400, message: "参数不合法"},
                 {code: 404, message: "找不到该条数据"},
                 {code: 500, message: "其他未知错误"}]
      end
      params do
        requires :all, except: [:frame, :engine, :vtype], using: API::Entities::Vehicle.documentation.except(:user)
        optional :appkey, type: String, desc: 'appkey'
      end
      put do
        params.delete :appkey
        item_ = UserVehicle.find(params[:id])
        item_.update params
      end

      desc '删除车辆' do
        failure [{code: 200, message: 'OK'},
                 {code: 400, message: "参数不合法"},
                 {code: 404, message: "找不到该条数据"},
                 {code: 500, message: "其他未知错误"}]
      end
      params do
        requires :id, type: Integer, desc: '车辆Id', documentation: {example: '1'}
        optional :appkey, type: String, desc: 'appkey'
      end
      delete do
        UserVehicle.destroy(params[:id])
      end
    end
  end
end