# Dir["#{Rails.root}/app/api/entities/*.rb"].each { |file| require file }
module API
  class UserDevices < Grape::API
    include API::Defaults
    namespace :device do
      desc "开启或关闭推送"
      params do
        requires :user, type: Integer, desc: '用户Id'
        requires :device, type: String, desc: '设备Id'
        requires :status, type: Integer, values: [0, 1], desc: '0:关 1：开'
      end
      get "switch" do
        devices = UserDevice.where(user: params[:user],device: params[:device]).all
        dp = declared params
        if devices.size > 0
          devices.each do |item_|
            item_.update dp
          end
        else
          UserDevice.create dp
        end
      end

      desc "获取车辆违章后通知推送服务器"
      params do
        requires :vehicle, type: Integer, desc: '车辆Id'
        requires :device, type: String, desc: '设备Id'
      end
      get "update" do
        devices = VehicleDevice.where(vehicle: params[:user],device: params[:device]).all
        dp = declared(params)
        time_hash = {lw: Time.now}
        if devices.size > 0
          devices.each do |item_|
            item_.update time_hash
          end
        else
          VehicleDevice.create dp.merge(time_hash)
        end
      end
    end
  end
end