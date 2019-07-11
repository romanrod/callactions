module Serializers
  class Activity

    def initialize(activity)
      @activity = activity
    end

    def as_json(*)
      begin
        data = {
          id: @activity.id.to_s,
          contact_id: @activity.contact_id.to_s,
          description: @activity.description,
          created_at: @activity.created_at,
          updated_at: @activity.updated_at
        }
      rescue => e
        data = {errors: "#{e}"}
      end

      data[:errors] = @activity.errors if @activity.errors.any?
      data
    end
  end
end


