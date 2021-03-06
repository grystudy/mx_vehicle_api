# Dir["#{Rails.root}/app/api/entities/*.rb"].each { |file| require file }
module API
  class UserDevices < Grape::API
    include Defaults
    namespace :device do
      desc "开启或关闭推送" do
        failure [{code: 200, message: 'OK'},
                 {code: 400, message: "参数不合法"},
                 {code: 404, message: "尝试关闭推送时,找不到用户设备记录"},
                 {code: 500, message: "其他未知错误"}]
      end
      params do
        requires :user, type: String, desc: '用户Id'
        requires :device, type: String, desc: '设备Id'
        requires :status, type: Integer, values: [0, 1], desc: '0:关 1：开'
        requires :dtype, type: Integer, values: [0, 1], default: 0, desc: '设备类型 0:安卓 1：ios'
        optional :appkey, type: String, desc: 'appkey'
      end
      get "switch" do
        devices = UserDevice.where(user: params[:user], device: params[:device]).all
        dp = declared params
        dp.delete :appkey
        if devices.size > 0
          devices.each do |item_|
            item_.update dp
          end
        else
          error!({message: "尝试关闭推送时,找不到用户设备记录"}, 404) if params[:status] == 0
          UserDevice.create dp
        end
      end

      desc "获取车辆违章后通知推送服务器" do
        failure [{code: 200, message: 'OK'},
                 {code: 400, message: "参数不合法"},
                 {code: 404, message: "找不到车辆记录"},
                 {code: 500, message: "其他未知错误"}]
      end
      params do
        requires :vehicle, type: Array[Integer], desc: '多个车辆Id用逗号分隔', coerce_with: ->(val) { val.split(',').map(&:to_i) }, documentation: {example: '1,2,3'}
        requires :device, type: String, desc: '设备Id'
        optional :appkey, type: String, desc: 'appkey'
      end
      put "update" do
        vehicles = params[:vehicle]
        vehicle_exist_ids = UserVehicle.where(id: vehicles).all.map { |i_| i_.id }
        error!({message: "找不到车辆记录"}, 404) if vehicle_exist_ids.size == 0
        devices = VehicleDevice.where(vehicle: vehicle_exist_ids, device: params[:device]).all
        time_hash = VehicleDevice.get_queried_now_hash
        if devices.size > 0
          devices.each do |item_|
            item_.update time_hash
          end
        else
          if vehicles.size > 0
            results = []
            dp = declared(params)
            dp.delete(:vehicle)
            dp.delete :appkey
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