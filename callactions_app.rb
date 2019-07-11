begin
  require_relative 'loader'
rescue => e
  puts "ERROR:#{e}"
  exit
end

class CallactionsApp < Sinatra::Base

  register Sinatra::Namespace
  
  helpers Helpers::Halts
  helpers Helpers::Contact
  helpers Helpers::Activity
  helpers Helpers::General


  set :allow_origin, "*"
  set port: 8080

  not_found do
    message = response_message || "Resource not found"      
    content_type 'application/json'
    [404, {"code" => 404, "message" => message}.to_json]
  end
  
  error 500 do
    content_type 'application/json'
    [500, {"code" => 500, "message" => "Internal server error"}.to_json]
  end

  namespace '/v1' do
    before do
      content_type 'application/json'
    end

    error 500 do
      content_type 'application/json'
      [500, {"code" => 500, "message" => "Internal server error"}.to_json]
    end

    register Sinatra::Contact
    register Sinatra::Activity
    
  end

end
puts "Callactions App has been started"