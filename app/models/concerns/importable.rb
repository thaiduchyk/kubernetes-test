# frozen_string_literal: true

module Importable
  extend ActiveSupport::Concern

  def import_to_primary
    raise NotImplementedError, 'Child class must implement #import_to_primary'
  end

  def perform_import
    PrimaryBase.transaction do
      yield if block_given?
    rescue StandardError => e
      Rails.logger.error("Import of record #{self.inspect} failed with error: #{e.full_message}")
    end
  end

  def build_object(model)
    obj_attrs = get_object_attrs(model)
    import_map[model]['direct'].each { |old_attr, new_attr| obj_attrs[new_attr] = obj_attrs.delete(old_attr) }
    import_map[model]['custom']&.each { |_attr, method_name| send(method_name, obj_attrs) }
    model.new(obj_attrs)
  end

  def get_object_attrs(model)
    attrs = import_map[model]['direct'].keys
    attrs += import_map[model]['custom'].keys if import_map[model]['custom']
    attributes.slice(*attrs)
  end

  def import_map
    self.class::IMPORT_MAP
  end
end
