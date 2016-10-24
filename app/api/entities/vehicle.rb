module API
  module Entities
    class Vehicle < Grape::Entity
      expose :id, documentation: {type: Integer, desc: '车辆Id', required: true}
      expose :user, documentation: {type: Integer, desc: '用户Id', required: true}
      expose :plate, documentation: {type: String, desc: '车牌号', required: true}
      expose :frame, documentation: {type: String, desc: '车架号'}
      expose :engine, documentation: {type: String, desc: '发动机号'}
      expose :vtype, documentation: {type: Integer, default: 2, values: [1, 2], desc: '车辆类型,2为小型车'}
    end
  end
end
