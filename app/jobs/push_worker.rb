class PushWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence {secondly(30) }

  def perform
    puts "sidetip ttt"
  end
end