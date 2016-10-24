# Dir["#{Rails.root}/app/api/entities/*.rb"].each { |file| require file }
module API
  class UserDevices < Grape::API
    # include API::Defaults
    namespace :device do
      desc "开启或关闭推送"
      params do
        requires :user, type: Integer, desc: '用户Id'
        requires :device, type: String, desc: '设备Id'
        requires :status, type: Integer, values: [0, 1], desc: '0:关 1：开'
      end
      get "switch" do
        devices = UserDevice.where(user: params[:user], device: params[:device]).all
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
        requires :vehicle, type: Array[Integer], desc: '多个车辆Id用逗号分隔', coerce_with: ->(val) { val.split(',').map(&:to_i) }, documentation: { example: '1,2,3' }
        requires :device, type: String, desc: '设备Id'
      end
      put "update" do
        vehicles = params[:vehicle]
        devices = VehicleDevice.where(vehicle: vehicles, device: params[:device]).all
        time_hash = {lw: Time.now}
        if devices.size > 0
          devices.each do |item_|
            item_.update time_hash
          end
        else
          if vehicles.size > 0
            results = []
            dp = declared(params)
            dp.delete(:vehicle)
            vehicles.each do |v_|
              results << dp.merge({vehicle: v_}.merge(time_hash))
            end
            VehicleDevice.create results
          end
        end
      end
    end
  end
end