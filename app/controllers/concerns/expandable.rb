# frozen_string_literal: true

module Expandable
  extend ActiveSupport::Concern

  module ClassMethods
    # we will support 2 types of expand:
    # internal - expanded resource is attribute of main resource:
    # {'orders': [ {'id': 1, 'customer': { 'id': 1 } } ] }
    # external - expanded resource has own root key (no duplicates of expanded resources):
    # {'orders': [{'id': 1 }], 'customers': [{ 'id': 1 }] }
    def enable_expand_fields(expand_config = {})
      unless expand_config.all? { |_k, v| v == :internal }
        raise ArgumentError, 'only internal expand is available at the moment'
      end

      define_singleton_method :expand_config do
        expand_config
      end
    end
  end

  included do
    before_action :parse_expand_param, only: %i[index show]
  end

  def expand?(relation_name)
    @expand_params.include?(relation_name)
  end

  def expandable_fields
    self.class.expand_config.keys
  end

  def expand_params
    @expand_params
  end

  private

  def parse_expand_param
    @expand_params = params[:expand].present? ? params[:expand].split(',').map(&:to_sym) : []
    @expand_params.reject!(&:empty?)
    unsupported_fields = @expand_params - expandable_fields

    invalid_expand_request_error(unsupported_fields) if unsupported_fields.any?
  end

  def invalid_expand_request_error(unsupported_fields)
    raise Errors::InvalidRequestError.new(
      nil,
      "Unsupported expand fields for this resource: #{unsupported_fields.join(',')}."
    )
  end

  def expand_resource(_resource, options)
    internal_expand_fields = expand_params.select { |field| self.class.expand_config[field] == :internal }
    options[:include] += internal_expand_fields
  end
end
