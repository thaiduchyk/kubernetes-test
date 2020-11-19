# frozen_string_literal: true

module Errors
  class InvalidRequestError < ApiBaseError
    CODE             = 'invalidRequest'
    HTTP_STATUS_CODE = 422
    TITLE = 'Client sent invalid request'
  end
end
