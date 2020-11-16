# frozen_string_literal: true

module Errors
  class InternalServerError < ApiBaseError
    CODE             = 'internalServerError'
    HTTP_STATUS_CODE = 500
    TITLE = 'Unexpected error'

    def details
      message
    end
  end
end
