module Bugcrowd
  class Client
    module SubmissionPriorities
      def get_submission_priority(submission_uuid, options={})
        response = Client.new.get("/submissions/#{submission_uuid}/priority", query: options)
      end

      def set_submission_priority(submission_uuid, priority, options={})
        response = Client.new.post("/submissions/#{submission_uuid}/priority", priority_params(priority), query: options)
      end

      def update_submission_priority(submission_uuid, priority, options={})
       response = Client.new.put("/submissions/#{submission_uuid}/priority", priority_params(priority), query: options)
      end

      def remove_submission_priority(submission_uuid, options={})
        response = Client.new.delete("/submissions/#{submission_uuid}/priority", query: options)
      end

      private

      def priority_params(priority)
        priority = priority.to_i
        raise 'priority must be an integer between 1 and 4' unless priority.between?(1,4)
        body = {
          priority: {
            level: priority
          }
        }
      end
    end
  end
end
