module Helpers
  module Activity

    def activity
      @activity ||= ::Activity.find(id: params[:act_id])
    end

    def show_activity
      Serializers::Activity.new(activity).to_json
    end

    def show_activities
      activities = contact.activities
      page = params["page"] ? params["page"].to_i : 1
      size = params["size"] ? params["size"].to_i : 10
      total = activities.size
      activities = activities.paginate(:page => page, :per_page => size).to_a.map do |activity|
        Serializers::Activity.new(activity)
      end
      {"total" => total, "page" => page, "size" => size, "activities" => activities}.to_json
    end

    def activity_exists?
      begin
        !!activity
      rescue
        false
      end
    end

    def save_activity request_data
      begin
        act = ::Activity.new(request_data)
        act.save!
      rescue Mongoid::Errors::Validations => e
        halt_400! e.summary
      rescue Mongoid::Errors::UnknownAttribute
        halt_400! "Bad request. Unknown attributes"
      rescue => e
        halt_500!
      end
      Serializers::Activity.new(act).to_json
    end

    def update_activity act_id, request_payload
      begin
        act = ::Activity.find(id: act_id)
        act.update request_payload
        act.save!
      rescue Mongoid::Errors::Validations => e
        halt_400! e.summary
      rescue Mongoid::Errors::UnknownAttribute
        halt_400! "Bad request. Unknown attributes"
      rescue => e
        halt_500!
      end
    end

    def delete_activity!
      begin
        halt_200!("Activity deleted") if activity.destroy!
        raise "Could not delete activity"
      rescue => e
        halt_409! "#{e}"
      end
    end

  end
end