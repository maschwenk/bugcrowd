require 'active_model'
require 'time'

module Bugcrowd
  class SubmissionCreateParams
    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON

    DATE_FORMAT = "%d-%m-%Y %H:%M:%S".freeze

    attr_accessor :title, :submitted_at

    validates :title, presence: true, length: { minimum: 3, maximum: 255 }
    validate :submitted_at_follows_format


    def attributes
      { submitted_at: nil, title: nil }
    end

    def submitted_at_follows_format
      return errors.add(:submitted_at, "can't be blank") if submitted_at.blank?
      Time.strptime(submitted_at, DATE_FORMAT) rescue errors.add(:submitted_at, "does not follow format %d-%m-%Y %H:%M:%S")
    end

    def initialize(opts = {})
      opts.each do |opt, val|
        send("#{opt}=", val) if respond_to? "#{opt}="
      end
    end
  end
end
