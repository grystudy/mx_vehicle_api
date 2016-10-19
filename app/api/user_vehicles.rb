Dir["#{Rails.root}/app/api/entities/*.rb"].each { |file| require file }
module API
  class UserVehicles < Grape::API
    include API::Defaults
    namespace :vehicle do
      desc "获取用户的车辆列表"
      params do
        requires :user, type: Integer, desc: '用户Id'
      end
      get do
        vehicles = UserVehicle.where(user: params[:user]).all
        present :all, vehicles, with: Entities::Vehicle
      end

      desc '创建车辆' do
        params API::Entities::Vehicle.documentation
      end
      post do
        new_ = UserVehicle.create! params
        present id: new_.id
      end

      desc '更新车辆' do
        params API::Entities::Vehicle.documentation
      end
      put ":id" do
        item_ = UserVehicle.find_by_id(params[:id])
        item_.update params
      end

      desc '删除车辆'
      params do
        requires :id, type: Integer, desc: '车辆Id', documentation: { example: '1'}
      end
      delete ':id' do
        UserVehicle.destroy(params[:id])
      end
    end
  end
end