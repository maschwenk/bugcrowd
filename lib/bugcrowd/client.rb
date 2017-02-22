require 'bugcrowd/client/bounties'
require 'bugcrowd/client/submissions'
require 'bugcrowd/client/submission_priority'
require 'bugcrowd/client/submissions_params'
require 'excon'

module Bugcrowd
  class Client
    include Bugcrowd::Client::Bounties
    include Bugcrowd::Client::Submissions
    include Bugcrowd::Client::SubmissionPriorities

    API_ENDPOINT = "https://api.bugcrowd.com".freeze
    USER_AGENT = "Bugcrowd Ruby Gem #{Bugcrowd::VERSION}".freeze
    MEDIA_TYPE = "application/vnd.bugcrowd+json"
    CONTENT_TYPE = "application/json".freeze

    attr_accessor :username, :password

    def initialize(username: ENV['BUGCROWD_USER'], password: ENV['BUGCROWD_PASSWORD'])
      self.username = username
      self.password = password
    end

    def inspect
      inspected = super

      inspected = inspected.gsub! self.username, "*******" if self.username
      inspected = inspected.gsub! self.password, "*******" if self.password

      inspected
    end

    def put(path, body, options = {})
      options.merge!(path: path, expects: 200, body: JSON.generate(body))
      connection.put(options)
    end

    def post(path, body, options = {})
      options.merge!(path: path, expects: 201, body: JSON.generate(body))
      connection.post(options)
    end

    def delete(path, options = {})
      options.merge!(path: path, expects: 200)
      connection.delete(options)
    end

    def get(path, options = {})
      options.merge!(path: path, expects: 200)
      connection.get(options)
    end

    def connection_options
      {
        headers: {
          "Accept" => MEDIA_TYPE,
          "User-Agent" => USER_AGENT,
          "Content-Type" => CONTENT_TYPE
        },
        user: self.username,
        password: self.password
      }
    end

    def connection
      @connection = Excon.new(API_ENDPOINT, connection_options)
    end
  end
end
