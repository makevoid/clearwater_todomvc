require 'bundler'
Bundler.require
require 'tilt/haml'

Opal.append_path File.expand_path('../assets/js', __FILE__)

APP_ENV = ENV["RACK_ENV"] || "development"

COMPILE_ASSETS = true
# COMPILE_ASSETS = false
# COMPILE_ASSETS = ENV['COMPILE_ASSETS']

JS_HEADERS_CACHE = {"Cache-control" => "no-cache, no-store, must-revalidate", "Pragma" => "no-cache", "Expires" => "0"}
JS_HEADERS = COMPILE_ASSETS ? {} : (APP_ENV == "development" ? JS_HEADERS_CACHE : {})

class TryClearwater < Roda
  plugin :render, engine: 'haml'
  plugin :assets,
    js: 'application.rb', js_opts: { builder: Opal::Builder.new }, js_headers: JS_HEADERS,
    css: %w(vendor/milligram.css style.css)
  compile_assets if COMPILE_ASSETS

  route do |r|
    r.assets

    view 'index'
  end
end
