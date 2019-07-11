module Helpers
  module Halts
    
    def halt_if_contact_not_found!
      halt_404!("Contact not found") unless contact_exists?
    end

    def halt_if_activity_not_found!
      halt_404!("Activity not found") unless activity_exists?
    end

    def halt_if_activity_isnt_from_contact!
      halt_404!("Activity not found") unless contact_has_activity? activity
    end

    def halt_200! message 
      halt(200, {status: 200, message: message}.to_json)
    end

    def halt_400! message = nil
      message = "Bad request" if message.nil?
      halt(400, {status: 400, message: message}.to_json)
    end

    def halt_401! message = nil
      message = "Unathorized" if message.nil?
      halt(401, {status: 401, message: message}.to_json)
    end

    def halt_404! message = nil
      message = "Not found" if message.nil?
      halt(404, {status: 404, message: message}.to_json)
    end

    def halt_409! message = nil
      message = "Conflict" if message.nil?
      halt(409, {status: 409, message: message}.to_json)
    end

    def halt_500!
      halt(500, {status: 500, message: 'Internal Server Error'}.to_json)
    end
  end
end