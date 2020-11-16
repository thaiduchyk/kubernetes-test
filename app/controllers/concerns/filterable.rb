# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  FIELD_TYPES_FOR_PARSE = %w[boolean integer].freeze

  included do
    before_action -> { parse_query_filters(self.class.available_filter_fields) }, only: [:index]

    attr_accessor :filters
  end

  def parse_query_filters(fields)
    @filters = {}
    fields.each { |field| parse_field_filter(field) }
  end

  def filter_by?(field)
    filters.keys.include?(field)
  end

  def scope_by_query_params(relation)
    return relation if @filters.blank?

    model = relation.respond_to?(:model) ? relation.model : relation

    @filters.each do |field, list|
      where_clause = { model.table_name => { field => list } }

      relation = relation.where(where_clause)
    end

    relation
  end

  private

  def parse_field_filter(field)
    return if params[field].blank?

    list = params[field].split(',')

    FIELD_TYPES_FOR_PARSE.each do |type|
      next unless self.class.send("#{type}_filter_fields").include?(field)

      list.map! do |value|
        Utils.send("parse_#{type}", value)
      end
    end

    @filters[field.to_sym] = list
  end

  module ClassMethods
    def enable_query_filters(filter_fields, boolean: [], integer: [])
      raise ArgumentError, 'filter_fields must be an Array' unless filter_fields.is_a?(Array)

      define_singleton_method :available_filter_fields do
        filter_fields
      end

      define_singleton_method :boolean_filter_fields do
        boolean
      end

      define_singleton_method :integer_filter_fields do
        integer
      end
    end
  end
end
