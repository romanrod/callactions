require 'byebug'
require 'json'
module Sinatra
  module Activity
    
    def self.registered(app)

    #   GET        /contacts/:id/activities
    # - POST      /contacts/:id/activities
    # - PUT        /contacts/:id/activities/:id
    # - DELETE
      
      app.get '/contacts/:id/activities/:act_id' do |user_id, activity_id|
        halt_if_contact_not_found!
        halt_if_activity_not_found!
        halt_if_activity_isnt_from_contact!
        show_activity
      end

      app.get '/contacts/:id/activities' do |contact_id|
        halt_if_contact_not_found!
        show_activities
      end

      app.post '/contacts/:id/activities' do |contact_id|
        halt_if_contact_not_found!
        payload = request_payload
        payload["contact_id"] = contact_id
        save_activity payload
      end

      app.put '/contacts/:id/activities/:act_id' do |user_id, activity_id|
        halt_if_contact_not_found!
        halt_if_activity_not_found!
        update_activity activity_id, request_payload
      end

      app.delete '/contacts/:id/activities/:act_id' do |user_id, activity_id|
        halt_if_activity_not_found!
        delete_activity!
      end
      

    end
  end
end
