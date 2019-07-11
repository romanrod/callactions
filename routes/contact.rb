require 'byebug'
require 'json'
module Sinatra
  module Contact
    
    def self.registered(app)

      app.get '/contacts' do
        show_contacts
      end

      app.get '/contacts/:id' do |contact_id|
        halt_if_contact_not_found!
        show_contact
      end
      
      app.post '/contacts' do
        create_contact(request_payload)
      end

      app.delete '/contacts/:id' do |user_id|
        halt_if_contact_not_found!
        delete_contact!
      end

      app.put '/contacts/:id' do |user_id|
        halt_if_contact_not_found!
        update_contact user_id, request_payload
      end

      app.get '/version' do
        { "version" => Callactions::VERSION}.to_json
      end


    end
  end
end
