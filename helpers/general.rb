module Helpers
  module General

    def request_payload
      begin       
        JSON.parse(request.body.read)
      rescue => e
        halt_400! "Invalid data #{e}"
      end
    end

    def response_message
      begin
        JSON.parse(response.body.first)["message"]
      rescue => e      
      end
    end
    
  end  
end