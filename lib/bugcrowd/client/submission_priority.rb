module Bugcrowd
  class Client
    module SubmissionPriorities
      def get_submission_priority(submission_uuid)
        response = Client.new.get("/submissions/#{submission_uuid}/priority")
      end

      def set_submission_priority(submission_uuid, priority)
        response = Client.new.post("/submissions/#{submission_uuid}/priority", priority_params(priority))
      end

      def update_submission_priority(submission_uuid, priority)
       response = Client.new.put("/submissions/#{submission_uuid}/priority", priority_params(priority))
      end

      def remove_submission_priority(submission_uuid)
        response = Client.new.delete("/submissions/#{submission_uuid}/priority")
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
