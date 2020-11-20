# frozen_string_literal: true

class BaseController < ApplicationController
  include Filterable
  include Expandable

  DEFAULT_LIMIT = 100

  attr_reader :resource

  before_action :find_resource, only: %i[show update destroy]
  before_action :parse_limit_param, only: %i[index]

  def find_resource
    return unless (id = params[:id])

    @resource = resource_class.find(id)
  rescue ActiveRecord::RecordNotFound => e
    raise Errors::ResourceNotFoundError.new(e, 'Requested resource can not be found')
  end

  def collection
    collection = resource_class.limit(@limit).with_preloaded_relations(expand_params)
    scope_by_query_params(collection)
  end

  def resource_class
    self.class.name.demodulize.chomp('Controller').singularize.constantize
  end

  def render_resource(resource, options = {})
    options[:include] = []
    expand_resource(resource, options) if @expand_params.present?
    options[:json] = resource
    render options
  end

  def render_collection(collection, options = {})
    options[:include] = []
    expand_resource(collection, options) if @expand_params.present?
    options[:json] = collection
    render options
  end

  def parse_limit_param
    @limit = params[:limit] ? Utils.parse_integer(params[:limit]) : DEFAULT_LIMIT
  rescue ArgumentError
    msg = "Invalid integer format for the limit parameter: #{params[:limit]}."
    raise Errors::InvalidRequestError.new(nil, msg)
  end
end
