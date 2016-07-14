require 'bundler'
Bundler.require
require 'tilt/haml'

Opal.append_path File.expand_path('../assets/js', __FILE__)

class TryClearwater < Roda
  plugin :render, engine: 'haml'
  plugin :assets,
    js: 'application.rb', js_opts: { builder: Opal::Builder.new },
    css: %w(vendor/milligram.css style.css)
  compile_assets if ENV['COMPILE_ASSETS']

  route do |r|
    r.assets

    view 'index'
  end
end
