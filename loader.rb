require 'require_all'
require 'sinatra/base'
require 'sinatra/namespace'
require 'sinatra'
require 'mongoid'
require 'require_all'
require 'clipar'
require 'byebug'

require_all 'lib'
require_all 'models'
require_all 'serializers'
require_all 'helpers'

Dir["./routes/*.rb"].each {|rb| require rb}

$cli = CLIPar.new
