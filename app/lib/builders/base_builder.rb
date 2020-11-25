# frozen_string_literal: true

module Builders
  class BaseBuilder
    attr_reader :resource, :params, :error

    def initialize(params, current_user = nil)
      @params       = params.to_h.with_indifferent_access
      @current_user = current_user
    end

    def build
      @resource = initialize_resource
      assign_params
      assign_related_resources
      @resource
    end

    def create
      build
      save
    end

    def update(resource)
      @resource = resource
      assign_params
      save
    end

    private

    def save
      @resource.save!
    rescue ActiveRecord::RecordInvalid
      initialize_record_invalid_error
      false
    end

    def initialize_record_invalid_error
      @error = Errors::InvalidResourceError.new
      @resource = nil
    end

    def initialize_resource
      raise NotImplementedError, 'Child class must implement #initialize_resource'
    end

    def assign_params
      @resource.assign_attributes(@params)
    end

    def assign_related_resources; end
  end
end
