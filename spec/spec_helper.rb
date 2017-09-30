RACK_ENV = 'test'.freeze unless defined?(RACK_ENV)
require 'simplecov'
SimpleCov.start do
  add_filter './spec/'
end

def require_all(path)
  arr = Dir[File.join(File.dirname(__FILE__), path)]
  raise "No such files found: #{path}" if arr.empty?
  arr.each(&method(:require))
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app VimRCG::App
#   app VimRCG::App.tap { |a| }
#   app(VimRCG::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end

require_all '../config/boot.rb'
require_all '../{spec/support,app/helpers}/**/*.rb'

RSpec.configure do |conf|
  conf.include Capybara::DSL
  conf.include VimRCG::RSpecHelper
  conf.before(:each) do
    app VimRCG::App
  end
end
