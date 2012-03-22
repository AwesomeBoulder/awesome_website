require "net/http"

class ProxyApp
  def call(env)
    begin
      request = Rack::Request.new(env)
      headers = {}
      http = Net::HTTP.new(request.host, 8888)      
      response = http.send_request(request.request_method, request.fullpath, request.body.read, headers)

      # Map Net::HTTP response back to Rack::Request.call expects
      status, headers, body = response.code, response.to_hash, [response.body]

      # Research showed that browsers were choking on this for some reason.
      # Probably not the be-all-end-all solution, but works for local development thus far.
      headers.delete('transfer-encoding')
      
      # Send the response back to POW
      [status, headers, body]
    rescue Errno::ECONNREFUSED => e
      [500, {}, ["Server is down, try $ sudo apachectl start\n #{e.class}=>#{e.message}"]]
    end
  end
end
run ProxyApp.new

# require 'rack'
# require 'rack-legacy'
# require 'rack-rewrite'
# 
# INDEXES = ['index.html','index.php', 'index.cgi']
# 
# use Rack::Rewrite do
#   rewrite %r{(.*/$)}, lambda {|match, rack_env|
#     INDEXES.each do |index|
#       if File.exists?(File.join(Dir.getwd, rack_env['PATH_INFO'], index))
#         return rack_env['PATH_INFO'] + index
#       end
#     end
#     rack_env['PATH_INFO']
#   }
# end
# 
# use Rack::Legacy::Php, Dir.getwd
# use Rack::Legacy::Cgi, Dir.getwd
# run Rack::File.new Dir.getwd
