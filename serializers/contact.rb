module Serializers
  class Contact

    def initialize(contact)
      @contact = contact
    end

    def as_json(*)
      begin
        data = {
          id: @contact.id.to_s,
          first_name: @contact.first_name,
          last_name: @contact.last_name,
          cell_phone: @contact.cell_phone,
          zip_code: @contact.zip_code,
          created_at: @contact.created_at,
          updated_at: @contact.updated_at,
          
        }
      rescue => e
        data = {errors: "#{e}"}
      end

      data[:errors] = @contact.errors if @contact.errors.any?
      data
    end
  end
end


