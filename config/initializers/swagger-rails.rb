GrapeSwaggerRails.options.url      = "/api/v1/swagger_doc"
#GrapeSwaggerRails.options.app_url  = '/'
# GrapeSwaggerRails.options.before_filter_proc = proc {
#   GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
# }
GrapeSwaggerRails.options.app_url  = "#{ENV['APPLICATION_URL']}"
