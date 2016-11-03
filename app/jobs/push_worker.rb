class PushWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence {secondly(1) }

  def perform
    puts "sidetip ttt"
  end
end

module AA
  PushWorker.perform_async
end