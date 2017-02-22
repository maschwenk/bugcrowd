require 'bugcrowd/client/submissions_params'

module Bugcrowd
  class Client
    module Submissions
      def list_submissions(bounty_uuid, options={})
        response = Client.new.get("/bounties/#{bounty_uuid}/submissions", query: options)
      end

      def create_submission(bounty_uuid, **params)
        response = Client.new.post("/bounties/#{bounty_uuid}/submissions", submission_create_params(params))
      end

      def get_submission(submission_uuid)
        response = Client.new.get("/submissions/#{submission_uuid}")
      end

      def update_submission(submission_uuid, **params)
        response = Client.new.put("/submissions/#{submission_uuid}", params)
      end

      private

      def submission_create_params(**params)
        param_obj = SubmissionCreateParams.new(params)
        param_obj.validate!
        param_obj.as_json.merge!(params)
      end
    end
  end
end
