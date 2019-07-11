module Helpers
  module Contact

    def contact
      @contact ||= ::Contact.find(id: params[:id])
    end

    def show_contact
      Serializers::Contact.new(contact).to_json
    end

    def show_contacts
      contacts = ::Contact.where({}).desc(:created_at)
      page = params["page"] ? params["page"].to_i : "1"
      size = params["size"] ? params["size"].to_i : "10"
      [:first_name, :last_name, :cell_phone, :zipcode].each do |filter|
        contacts = contacts.send(filter, params[filter]) if params[filter]
      end
      total = contacts.size
      contacts = contacts.paginate(:page => page, :per_page => size).to_a.map do |contact|
        Serializers::Contact.new(contact)
      end
      {"total" => total, "page" => page, "size" => size, "contacts" => contacts}.to_json
    end

    def contact_exists?
      begin
        !!contact
      rescue
        false
      end
    end

    def contact_has_activity? activity_id
      contact.has_activity? activity_id
    end

    def create_contact request_data
      begin
        con = ::Contact.new(request_data)
        con.save!
      rescue Mongoid::Errors::Validations => e
        halt_400! e.summary
      rescue Mongoid::Errors::UnknownAttribute
        halt_400! "Bad request. Unknown attributes"
      rescue => e
        halt_500!
      end
      Serializers::Contact.new(con).to_json
    end

    def update_contact user_id, request_payload
      begin
        con = ::Contact.find(id: user_id)
        con.update request_payload
      rescue Mongoid::Errors::Validations => e
        halt_400! e.summary
      rescue Mongoid::Errors::UnknownAttribute
        halt_400! "Bad request. Unknown attributes"
      rescue => e
        halt_500!
      end
      Serializers::Contact.new(con).to_json
    end

    def delete_contact!
      begin
        halt_200!("Contact deleted") if contact.destroy!
        raise "Could not delete contact"
      rescue => e
        halt_409! "#{e}"
      end
    end

  end
end
