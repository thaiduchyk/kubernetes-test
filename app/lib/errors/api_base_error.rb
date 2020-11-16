# frozen_string_literal: true

module Errors
  # https://jsonapi.org/format/#errors
  class ApiBaseError < StandardError
    extend ActiveModel::Naming
    include ActiveModel::Serialization
    
    HTTP_STATUS_CODE = 500
    CODE = 'baseError'
    TITLE = 'This is base error'

    attr_reader :uid

    def initialize(ex_or_msg = nil, detailed_message = nil)
      msg = case ex_or_msg
            when Exception
              ex_or_msg.message
            when String
              @client_message = ex_or_msg
            else
              ex_or_msg
            end
      super(msg)
      @details = []
      @details << detailed_message if detailed_message
      @uid = SecureRandom.uuid
    end

    def code
      self.class::CODE
    end

    def http_status_code
      self.class::HTTP_STATUS_CODE
    end

    def title
      self.class::TITLE
    end

    def details
      @details.present? ? @details : [title]
    end

    def add_detail(detail)
      details << detail
    end
  end
end
