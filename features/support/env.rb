ENV['RACK_ENV']='test'
require 'byebug'
require 'require_all'
require 'rack/test'

require "#{Dir.pwd}/loader.rb"
require "#{Dir.pwd}/callactions_app.rb"

include Rack::Test::Methods

def app
  CallactionsApp
end

def content_type
  { 'CONTENT_TYPE' => 'application/json' }
end

def parsed_response
  JSON.parse(last_response.body)
end
