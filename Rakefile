require 'rubygems'
require 'byebug'

task :test do
  system "bundle exec cucumber"  
end

task :start do
  system "RACK_ENV=local rackup config.ru"
end
