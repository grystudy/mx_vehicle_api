require 'sidetiq/web'
require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	mount API::API => '/'
	mount GrapeSwaggerRails::Engine => '/apidoc'
	mount Sidekiq::Web ,at: "/admin"
end
