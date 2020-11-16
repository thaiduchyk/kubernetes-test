# frozen_string_literal: true

module Errors
  class ResourceNotFoundError < ApiBaseError
    HTTP_STATUS_CODE = 404
    CODE = 'notFound'
    TITLE = 'Resource not found'
  end
end
