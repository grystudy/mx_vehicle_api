Dir["#{Rails.root}/app/api/entities/*.rb"].each { |file| require file }
module API
  module Entities
    class Base < Grape::Entity
      # include API::Entities::Defaults
    end
  end
end
