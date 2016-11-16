requrie "time"
class VehicleDevice < ApplicationRecord
  # lw 代表推送时候的最近一条违章time
  # lp 代表推送轮寻最近一次查询的时间
  def need_requery?
    last_query = lp
    unless last_query
      need_ = true
    else
      # 1 day
      need_ = (DateTime.now - last_query.to_datetime).abs.to_f > 1
    end
    need_ = true
    lp = DateTime.now if need_
    need_
  end

  def need_push? wz_items
    # 根据时间判断结果是否推送，然后更新时间
    return false unless wz_items && wz_items.size > 0
    times = wz_items.map do |e_|
      time = e_.fetch(:time,nil)
      Time.parse(time)
    end.sort
    return false if times.size == 0
    last_wz = lw
    return true unless lw
    times.last > last_wz.to_time
  end

  class << self
    def get_queried_now_hash
      {lq: Time.now}
    end
  end
end
