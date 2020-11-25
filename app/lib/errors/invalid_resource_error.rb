# frozen_string_literal: true

module Errors
  class InvalidResourceError < ApiBaseError
    CODE             = 'invalidResource'
    HTTP_STATUS_CODE = 422
    TITLE = 'Resource payload is invalid'
  end
end
