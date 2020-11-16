# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from StandardError, with: :uncaught_error
  rescue_from Errors::ApiBaseError, with: :render_error

  private

  def render_error(error)
    render status: error.http_status_code, json: error, serializer: ErrorSerializer
  end

  def uncaught_error(error)
    internal_error = Errors::InternalServerError.new(error)
    render_error(internal_error)
  end
end
