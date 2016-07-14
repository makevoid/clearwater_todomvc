require './try_clearwater'

use Rack::Deflater if ENV["RACK_ENV"] == "production"
run TryClearwater
