# frozen_string_literal: true

class BaseController < ApplicationController
  include Filterable

  DEFAULT_LIMIT = 100

  attr_reader :resource

  before_action :find_resource, only: %i[show update destroy]

  def find_resource
    return unless (id = params[:id])

    @resource = resource_class.find(id)
  rescue ActiveRecord::RecordNotFound => e
    raise Errors::ResourceNotFoundError.new(e, 'Requested resource can not be found')
  end

  def collection
    collection = resource_class.limit(DEFAULT_LIMIT)
    scope_by_query_params(collection)
  end

  def resource_class
    self.class.name.demodulize.chomp('Controller').singularize.constantize
  end

  def render_resource(resource, options = {})
    options[:json] = resource
    render options
  end

  def render_collection(collection, options = {})
    options[:json] = collection
    render options
  end
end
